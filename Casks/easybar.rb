cask "easybar" do
  version "0.63.6"
  sha256 "9d02496e694b5bcca54d8c073ae9448c9e19551cb4733b5c7fb173b0f8188a4c"

  url "https://github.com/easybar-app/easybar/releases/download/v0.63.6/EasyBar-0.63.6.zip"
  name "EasyBar"
  desc "Scriptable status bar with SwiftUI and Lua widgets"
  homepage "https://easybar.dev/"

  depends_on formula: [
    "easybar-calendar-agent",
    "easybar-network-agent",
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
        args: ["services", "restart", "easybar-calendar-agent"]
    run "{{HOMEBREW_BREW_FILE}}",
        args: ["services", "restart", "easybar-network-agent"]
  end

  uninstall_preflight_steps do
    run "{{HOMEBREW_BREW_FILE}}",
        args: ["services", "stop", "easybar-calendar-agent"]
    run "{{HOMEBREW_BREW_FILE}}",
        args: ["services", "stop", "easybar-network-agent"]
  end

  zap trash: [
    "~/.config/easybar",
    "~/.local/state/easybar",
  ]
end
