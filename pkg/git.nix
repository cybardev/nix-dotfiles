{
  config,
  pkgs,
  lib,
  ...
}:
let
  fish.shellAbbrs =
    lib.mkIf config.programs.git.enable {
      # Git
      ga = "git add";
      gc = "git commit";
      gaa = "git add --all";
      gca = "git commit --amend";
      gcf = "git commit --fixup";
      gcm = "git commit --message";
      grb = "git rebase --interactive";
      gcam = "git commit --amend --message";
      grbs = "git rebase --interactive --autosquash";
    }
    // lib.mkIf config.programs.jujutsu.enable {
      # Jujutsu
      jic = "jj git init --colocate";
      ji = "jj git init";
      jcl = "jj git clone";
      jn = "jj new";
      ju = "jj undo";
      jc = "jj commit";
      jd = "jj describe -m";
      js = "jj squash";
      jp = "jj git push";
      jbm = "jj bookmark move main --to @-";
      jbmh = "jj bookmark move main --to @";
    };

  git = {
    enable = true;
    package = pkgs.gitFull;
    settings = {
      user = {
        name = "cybardev";
        email = "50134239+cybardev@users.noreply.github.com";
        signingKey = "~/.ssh/id_ed25519.pub";
      };
      init.defaultBranch = "main";
      credential.helper = "store";
      pull.rebase = false;
      gpg.format = "ssh";
      commit.gpgSign = true;
    };
  };

  lazygit = {
    enable = config.programs.git.enable;
    settings = {
      promptToReturnFromSubprocess = false;
      git = {
        pagers = [
          {
            pager = "${lib.getExe pkgs.delta} --paging=never --hyperlinks-file-link-format=\"lazygit-edit://{path}:{line}\"";
          }
        ];
      };
      gui = {
        theme = {
          activeBorderColor = [
            "#8ba4b0"
            "bold"
          ];
          inactiveBorderColor = [ "#a6a69c" ];
          optionsTextColor = [ "#8ba4b0" ];
          selectedLineBgColor = [ "#2d4f67" ];
          cherryPickedCommitBgColor = [ "#2d4f67" ];
          cherryPickedCommitFgColor = [ "#a292a3" ];
          unstagedChangesColor = [ "#c4746e" ];
          defaultFgColor = [ "#c5c9c5" ];
          searchingActiveBorderColor = [ "#c4b28a" ];
        };
        authorColors = {
          "*" = "#7fb4ca";
        };
        useHunkModeInStagingView = true;
      };
    };
  };

  jujutsu = {
    enable = false;
    settings = {
      user = { inherit (git.settings.user) name email; };
      remotes = {
        origin.auto-track-bookmarks = "glob:*";
        upstream.auto-track-bookmarks = "main";
      };
      git = {
        executable-path = lib.getExe config.programs.git.package;
        sign-on-push = true;
      };
      signing = {
        behavior = "own";
        backend = "ssh";
        key = git.settings.user.signingKey;
        backends.ssh.program = lib.getExe' pkgs.openssh "ssh-keygen";
      };
      fix.tools = {
        nixfmt = {
          patterns = [ "glob:'**/*.nix'" ];
          command = [ "nixfmt" ];
        };
        ruff = {
          command = [
            "ruff"
            "-"
            "--stdin-filename=$path"
          ];
          patterns = [ "glob:'**/*.py'" ];
        };
        gofumpt = {
          patterns = [ "glob:'**/*.go'" ];
          command = [ "gofumpt" ];
        };
        rustfmt = {
          command = [
            "rustfmt"
            "--emit"
            "stdout"
            "--edition"
            "2024"
          ];
          patterns = [ "glob:'**/*.rs'" ];
        };
        prettier = {
          command = [
            (lib.getExe pkgs.nodePackages.prettier)
            "--stdin-filepath=$path"
          ];
          patterns = [
            "glob:'**/*.html'"
            "glob:'**/*.css'"
            "glob:'**/*.scss'"
            "glob:'**/*.js'"
            "glob:'**/*.ts'"
            "glob:'**/*.jsx'"
            "glob:'**/*.tsx'"
          ];
        };
      };
      ui = {
        editor = lib.getExe config.programs.helix.package;
        merge-editor = "mergiraf";
      };
      revset-aliases = {
        "immutable_heads()" = lib.concatStringsSep " | " [
          "builtin_immutable_heads()"
          "(trunk().. & ~mine())"
        ];
      };
    };
  };

  jjui = {
    enable = config.programs.jujutsu.enable;
    configDir = "${config.xdg.configHome}/jjui";
    settings.ui.theme = "base16-kanagawa-dragon";
  };

  delta = {
    enable = true;
    enableGitIntegration = true;
    enableJujutsuIntegration = true;
    options = {
      dark = true;
      line-numbers = true;
      syntax-theme = "kanagawa-dragon";
      hyperlinks = true;
    };
  };

  mergiraf.enable = true;
in
{
  programs = {
    inherit
      fish
      git
      lazygit
      jujutsu
      jjui
      delta
      mergiraf
      ;
  };
}
