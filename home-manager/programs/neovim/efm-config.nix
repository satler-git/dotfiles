{ pkgs, lib, ... }:
let
  yamllint-lint = {
    prefix = "yamllint";
    lint-command = "${lib.getExe pkgs.yamllint} --strict --format parsable \${INPUT}";
    lint-stdin = false;
    lint-formats = [
      "%f:%l:%c: [%t%*[a-z]] %m"
    ];
    env = [
      "PYTHONIOENCODING=UTF-8"
    ];
  };
  actionlint-lint = {
    prefix = "actionlint";
    lint-command = "${lib.getExe pkgs.bash} -c \"[[ '\${INPUT}' =~ \\\\.github/workflows/ ]]\" && ${lib.getExe pkgs.actionlint} -oneline -no-color -";
    lint-stdin = true;
    lint-formats = [
      "%f:%l:%c: %m"
    ];
    root-markers = [ ".github" ];
  };
  clippy-lint = {
    prefix = "clippy";
    lint-command = "${lib.getExe pkgs.clippy}";
  };
in
{
  version = 2;

  root-markers = [
    ".git/"
    ".jj/"
  ];

  lint-debounce = "1s";

  commands = [
    {
      title = "Open (system default)";
      os = "linux";
      command = "xdg-open";
      arguments = [ "\${FILENAME}" ];
    }
  ];

  tools = {
    inherit actionlint-lint yamllint-lint clippy-lint;
  };

  languages = {
    yaml = [
      actionlint-lint
      yamllint-lint
    ];
    rust = [
      clippy-lint
    ];
  };
}
