# 🏰 My dotfiles!!

## Install

### 🖥️ In `luka`(prev: desktop)

```shell
sudo nixos-install --flake github:satler-git/dotfiles#luka
```

### In `tau`

```shell
sudo nixos-install --flake github:satler-git/dotfiles#tau
```

## Apply

### :desktop_computer: In `luka`(prev: desktop)

```shell
sudo nixos-rebuild switch --flake .#luka
```

### In `tau`

```shell
sudo nixos-rebuild switch --flake .#tau
```


# Credits

`./home-manager/modules/denops.nix` is Partial copy from [ttak0422/denops-shared-server-service](https://github.com/ttak0422/denops-shared-server-service).

Copyright (c) 2024 Tak

