cask "easybar" do
  version "0.64.3"
  sha256 "f3a4cc14ebce63f4ae60cf32b7a572f24944e3eeef8802d7851e2a4cb713d321"

  url "https://github.com/easybar-app/easybar/releases/download/v0.64.3/EasyBar-0.64.3.zip"
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
  end

  zap trash: [
    "~/.config/easybar",
    "~/.local/state/easybar",
  ]

  caveats <<~EOS
    After installing or upgrading EasyBar, activate the helper services with:
      brew services restart easybar-app/tap/easybar-calendar-agent
      brew services restart easybar-app/tap/easybar-network-agent
  EOS
end
