{
  config,
  pkgs,
  ...
}: let
  pnpmHome = "/home/louis/.local/share/pnpm";
in {
  nixpkgs.config.allowUnfree = true;

  home.username = "louis";
  home.homeDirectory = "/home/louis";

  home.stateVersion = "23.11";

  home.packages = [];

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

  home.sessionPath = [
    pnpmHome
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      c = "code ~/.dotfiles";
    };
    oh-my-zsh = {
      enable = true;
    };
    sessionVariables = {
      PNPM_HOME = pnpmHome;
      N_PREFIX = "$HOME/.n";
    };
  };

  programs.starship = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Louis Haftmann";
    userEmail = "30736553+LouisHaftmann@users.noreply.github.com";

    extraConfig = {
      commit.gpgsign = true;
      gpg = {
        format = "ssh";
        "ssh".program = "${pkgs._1password-gui}/bin/op-ssh-sign";
      };
      user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOkMV+Ie61LyGaFAMQSLCeMSZWyk1EAX8Vjr32l2rENf";
    };
  };

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentitiesOnly=yes
          IdentityAgent ~/.1password/agent.sock
    '';
  };

  programs.home-manager.enable = true;
}
