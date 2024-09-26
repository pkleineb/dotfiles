{ config, lib, pkgs, ... }:

{
  programs.firefox = {
    enable = true;

    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPolicies = {
        CaptivePortal = true;

        DisableTelementry = true;
        DisablePocket = true;
        DisableFirefoxStudies = true;
        DisableFirefoxAccounts = true;

        FirefoxHome = {
          Pocket = false;
          Snippets = false;
        };

        UserMessaging = {
          ExtensionRecommendations = false;
          SkipOnboarding = true;
        };

        # this is currently not working and search engine preferences
        # are stored in search.json.mozlz4 and really there isn't a
        # great way to change that file... stupid
        SearchEngines = {
          Default = "DuckDuckGo";
        };

        ExtensionSettings = {
          # uBlock Origin:
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "normal_installed";
          };
          # Bitwarden
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
            installation_mode = "normal_installed";
          };
          # New Tab Suspender
          "{6a65273e-2b26-40f5-b66e-8eed317307da}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/new-tab-suspender/latest.xpi";
            installation_mode = "normal_installed";
          };
          # Simple tab groups
          "simple-tab-groups@drive4ik" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/simple-tab-groups/latest.xpi";
            installation_mode = "normal_installed";
          };
        };

        Preferences = {
          "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
        };
      };
    };

    /* ---- PROFILES ---- */
    # Switch profiles via about:profiles page.
    # For options that are available in Home-Manager see
    # https://nix-community.github.io/home-manager/options.html#opt-programs.firefox.profiles
    profiles = {
      paul = {                # choose a profile name; directory is /home/<user>/.mozilla/firefox/profile_0
        id = 0;               # 0 is the default profile; see also option "isDefault"
        name = "paul";        # name as listed in about:profiles
        isDefault = true;     # can be omitted; true if profile ID is 0
        settings = {          # specify profile-specific preferences here; check about:config for options
          "browser.uiCustomization.state" = {
            placements = {
              "widget-overflow-fixed-list" = [];
              "unified-extensions-area" = [
                "_6a65273e-2b26-40f5-b66e-8eed317307da_-browser-action"
              ];
              "nav-bar" = [
                "back-button"
                "forward-button"
                "stop-reload-button"
                "customizableui-special-spring1"
                "urlbar-container"
                "customizableui-special-spring2"
                "save-to-pocket-button"
                "downloads-button"
                "fxa-toolbar-menu-button"
                "unified-extensions-button"
                "ublock0_raymondhill_net-browser-action"
                "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"
                "simple-tab-groups_drive4ik-browser-action"
              ];
              "toolbar-menubar" = [
                "menubar-items"
              ];
              TabsToolbar = [
                "firefox-view-button"
                "tabbrowser-tabs"
                "new-tab-button"
                "alltabs-button"
              ];
              PersonalToolbar = [
                "personal-bookmarks"
              ];
            };
            seen = [
              "save-to-pocket-button"
              "simple-tab-groups_drive4ik-browser-action"
              "ublock0_raymondhill_net-browser-action"
              "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"
              "_6a65273e-2b26-40f5-b66e-8eed317307da_-browser-action"
              "developer-button"
            ];
            dirtyAreaCache = [
              "unified-extensions-area"
              "nav-bar"
              "toolbar-menubar"
              "TabsToolbar"
              "PersonalToolbar"
            ];
            currentVersion = 20;
            newElementCount = 2;
          };
          "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
          "browser.startup.homepage" = "https://elb-innovations.de";
          "browser.newtabpage.pinned" = [
            {
              title = "NixOS";
              url = "https://nixos.org";
            }
            {
              title = "MyNixOS";
              url = "https://mynixos.com/";
            }
          ];
          "browser.startup.page" = 3;
          "browser.urlbar.placeholderName" = "DuckDuckGo";
          "browser.urlbar.placeholderName.private" = "DuckDuckGo";
        };
      };
    };
  };
}
