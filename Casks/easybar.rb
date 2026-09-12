cask "easybar" do
  version "0.64.2"
  sha256 "b4063830f5a40d4fa122489ca2047e3e084c23fb70854468a5e9f4e5050c4880"

  url "https://github.com/easybar-app/easybar/releases/download/v0.64.2/EasyBar-0.64.2.zip"
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
