cask "easybar" do
  version "0.30.3"
  sha256 "4098a08822eaee62c0ab6d4cab58bbc399b8834f6faf948f015316bb8c6bdbaa"

  url "https://github.com/gi8lino/easybar/releases/download/v0.30.3/EasyBar-0.30.3.zip"
  name "EasyBar"
  desc "Scriptable macOS status bar with SwiftUI and Lua widgets"
  homepage "https://github.com/gi8lino/easybar"

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
