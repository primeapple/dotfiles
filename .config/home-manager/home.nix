{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "toni";
  home.homeDirectory = "/home/toni";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    bat
    delta
    eza
    fd
    htop
    httpie
    jless
    jq
    neovim
    ripgrep
    toot
    trash-cli
    yt-dlp
    zf
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/toni/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting 'Welcome to fish 🐟'
      set fish_features qmark-noglob

      echo y | fish_config theme save kanagawa

      set -g fish_key_bindings fish_hybrid_key_bindings

      # default is 50 iirc
      set -g fish_escape_delay_ms 10

      if command -v bm >/dev/null
          command bm init fish | source
      end
    '';
    plugins = [
        { name = "autopair"; src = pkgs.fishPlugins.autopair.src; }
        # I'd much rather use a flake for that
        { name = "nvm"; src = pkgs.fishPlugins.nvm.src; }
        {
            name = "pufferfish";
            src = pkgs.fetchFromGitHub {
              owner = "nickeb96";
              repo = "puffer-fish";
              rev = "83174b07de60078be79985ef6123d903329622b8";
              sha256 = "0a4x985hzv77r5q8cly6580n488pf5iqlwkifrhzj9kifkwpj70f";
            };
        }
        { name = "tide"; src = pkgs.fishPlugins.tide.src; }
        { name = "z"; src = pkgs.fishPlugins.z.src; }
    ];
  };
}
