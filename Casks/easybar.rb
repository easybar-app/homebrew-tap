cask "easybar" do
  version "0.64.0"
  sha256 "3e1ba23a045e9f30042db9edfe6b4e8ddf57b12ef30af69239540ca4ab6a46d9"

  url "https://github.com/easybar-app/easybar/releases/download/v0.64.0/EasyBar-0.64.0.zip"
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
