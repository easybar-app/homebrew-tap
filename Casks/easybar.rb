cask "easybar" do
  version "0.6.1"
  sha256 "fe7fe63189526814776be014a1cc0bf29494af57b5f53ae96c0604b82e6dcb0c"

  url "https://github.com/easybar-app/easybar/releases/download/v0.6.1/EasyBar-0.6.1.zip"
  name "EasyBar"
  desc "Scriptable macOS status bar with SwiftUI and Lua widgets"
  homepage "https://github.com/easybar-app/easybar"

  depends_on formula: [
    "easybar-calendar-agent",
    "easybar-network-agent",
    "lua",
  ]
  depends_on macos: :sonoma

  postflight do
    system "xattr", "-d", "com.apple.quarantine", "#{staged_path}/easybar"
    system "xattr", "-dr", "com.apple.quarantine", "#{appdir}/EasyBar.app"
    system "#{HOMEBREW_PREFIX}/bin/brew", "services", "restart", "easybar-calendar-agent"
    system "#{HOMEBREW_PREFIX}/bin/brew", "services", "restart", "easybar-network-agent"
  end

  uninstall_preflight do
    system "#{HOMEBREW_PREFIX}/bin/brew", "services", "stop", "easybar-calendar-agent"
    system "#{HOMEBREW_PREFIX}/bin/brew", "services", "stop", "easybar-network-agent"
  end

  app "EasyBar.app"
  binary "easybar"

  zap trash: [
    "~/.config/easybar",
    "~/.local/state/easybar",
  ]
end
