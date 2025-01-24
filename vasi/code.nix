{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      mkhl.direnv
      github.copilot
    ];
    keybindings = [
      {
        key = "ctrl+g";
        command = "editor.action.nextMatchFindAction";
      }
    ];
    userSettings = {
      editor.fontSize = 13;
      editor.formatOnSave = true;
      editor.renderWhitespace = "trailing";
      editor.tabSize = 2;
      security.workspace.trust.enabled = false;
      window.titleBarStyle = "custom";
      workbench.editor.enablePreview = false;
      nix.enableLanguageServer = true;
      nix.serverPath = "nixd";
    };
  };
}
