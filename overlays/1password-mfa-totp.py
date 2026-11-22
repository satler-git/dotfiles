#!/usr/bin/env python3
"""Rebuild 1Password's app.asar so the MFA dialog prefers TOTP over a security key.

Why: 1Password 8.12.44 mounts the WebAuthn (security key) MFA view first, because
the dialog unsorted-entries map is ordered and `d[0]` is used as the initial
selection. That view fires `webauthnSign()` immediately and calls `onCancel()` when
the assertion fails, which tears down the whole MFA dialog before the user can pick
"Authentication Code" (TOTP). On Linux the assertion fails within ~40 ms, so an
account with a registered security key can never complete MFA, even with TOTP also
enrolled. Upstream has acknowledged the failure as a known issue; this patch only
changes the *default* selection, so a user who explicitly picks the security key
still gets the WebAuthn path.

Patch (minified renderer bundle):
    ...if(t===u)return d[e]}return d[0]})...
 -> ...if(t===u)return d[e];if(!u&&(t==="Totp"||t==="Code"))return d[e]}return d[0]})...

`u` is the explicitly selected method type, so the preference only applies while
nothing was chosen yet, and accounts without TOTP keep the original behaviour.

The asar is rewritten with recomputed SHA-256 `integrity` entries (Electron reads
them when present). Exits non-zero when the pattern is missing, so a nixpkgs bump
that changes the bundle fails loudly instead of silently shipping an unpatched app.
"""

import hashlib
import json
import struct
import sys

TARGET = b'if(t===u)return d[e]}return d[0]}),[d,u])'
REPLACEMENT = b'if(t===u)return d[e];if(!u&&(t==="Totp"||t==="Code"))return d[e]}return d[0]}),[d,u])'
PATCHED_FILE = "primaryRenderer.js"
DEFAULT_BLOCK_SIZE = 4 * 1024 * 1024


def iter_leaves(node, prefix=""):
    if "files" in node:
        for name, child in node["files"].items():
            yield from iter_leaves(child, f"{prefix}/{name}" if prefix else name)
    else:
        yield prefix, node


def integrity_for(blob, block_size):
    blocks = [
        hashlib.sha256(blob[i : i + block_size]).hexdigest()
        for i in range(0, len(blob), block_size)
    ]
    return {
        "algorithm": "SHA256",
        "hash": hashlib.sha256(blob).hexdigest(),
        "blockSize": block_size,
        "blocks": blocks,
    }


def main(path):
    with open(path, "rb") as fh:
        data = fh.read()

    pickle_payload = struct.unpack_from("<I", data, 4)[0]
    json_size = struct.unpack_from("<I", data, 12)[0]
    base = 8 + pickle_payload
    tree = json.loads(data[16 : 16 + json_size])

    chunks = []
    offset = 0
    patched = 0

    for name, node in iter_leaves(tree):
        if node.get("unpacked"):
            continue

        start = base + int(node["offset"])
        blob = data[start : start + node["size"]]

        if name == PATCHED_FILE:
            text = blob
            first = text.find(TARGET)
            if first == -1:
                raise SystemExit(
                    f"error: MFA patch target not found in {PATCHED_FILE}. "
                    "The renderer bundle changed (1Password update?); re-derive the patch."
                )
            if text.find(TARGET, first + 1) != -1:
                raise SystemExit(
                    f"error: MFA patch target is not unique in {PATCHED_FILE}; refusing to patch."
                )
            blob = text.replace(TARGET, REPLACEMENT)
            block_size = node.get("integrity", {}).get("blockSize", DEFAULT_BLOCK_SIZE)
            node["integrity"] = integrity_for(blob, block_size)
            node["size"] = len(blob)
            patched += 1

        node["offset"] = str(offset)
        chunks.append(blob)
        offset += len(blob)

    if patched != 1:
        raise SystemExit(f"error: expected to patch 1 file, patched {patched}")

    header = json.dumps(tree, separators=(",", ":")).encode()
    padding = (4 - len(header) % 4) % 4
    header_size = 4 + len(header) + padding
    pickle = 4 + header_size

    out = bytearray(8 + pickle + offset)
    struct.pack_into("<IIII", out, 0, 4, pickle, header_size, len(header))
    out[16 : 16 + len(header)] = header
    cursor = 16 + len(header) + padding
    for chunk in chunks:
        out[cursor : cursor + len(chunk)] = chunk
        cursor += len(chunk)
    if cursor != len(out):
        raise SystemExit(f"error: asar size mismatch ({cursor} != {len(out)})")

    with open(path, "wb") as fh:
        fh.write(out)

    print(f"patched {PATCHED_FILE}: asar rewritten ({len(out)} bytes, +{len(out) - len(data)})")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        raise SystemExit(f"usage: {sys.argv[0]} <path/to/app.asar>")
    main(sys.argv[1])
