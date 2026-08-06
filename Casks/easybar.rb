cask "easybar" do
  version "0.40.1"
  sha256 "74a9e60dba9c30bb2feb2ea7608ed3d2def0191791febbcc06fc6a7e84c0068c"

  url "https://github.com/gi8lino/easybar/releases/download/v0.40.1/EasyBar-0.40.1.zip"
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
