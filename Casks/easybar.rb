cask "easybar" do
  version "0.63.7"
  sha256 "3e26f384d63c157492d3abb6204e0d48e1c4251c4d4349cc0d8d8300bb5b0150"

  url "https://github.com/easybar-app/easybar/releases/download/v0.63.7/EasyBar-0.63.7.zip"
  name "EasyBar"
  desc "Scriptable status bar with SwiftUI and Lua widgets"
  homepage "https://easybar.dev/"

  depends_on formula: [
    "easybar-app/tap/easybar-calendar-agent",
    "easybar-app/tap/easybar-network-agent",
    "lua",
  ]
  depends_on macos: :sonoma

  app "EasyBar.app"
  binary "easybar"

  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-d", "com.apple.quarantine", "{{staged_path}}/easybar"],
        must_succeed: false
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/EasyBar.app"],
        must_succeed: false
    run "{{HOMEBREW_BREW_FILE}}",
        args: ["services", "restart", "easybar-app/tap/easybar-calendar-agent"]
    run "{{HOMEBREW_BREW_FILE}}",
        args: ["services", "restart", "easybar-app/tap/easybar-network-agent"]
  end

  uninstall_preflight_steps do
    run "{{HOMEBREW_BREW_FILE}}",
        args: ["services", "stop", "easybar-app/tap/easybar-calendar-agent"]
    run "{{HOMEBREW_BREW_FILE}}",
        args: ["services", "stop", "easybar-app/tap/easybar-network-agent"]
  end

  zap trash: [
    "~/.config/easybar",
    "~/.local/state/easybar",
  ]
end
