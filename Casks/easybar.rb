cask "easybar" do
  version "0.53.1"
  sha256 "4d368616d8558e80f1b6296abb215fd8c051a23a5ba4078b89173ed5b2fca8d9"

  url "https://github.com/easybar-app/easybar/releases/download/v0.53.1/EasyBar-0.53.1.zip"
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
