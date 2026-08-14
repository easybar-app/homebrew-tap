cask "easybar-native" do
  version "0.4.0"
  sha256 "3ad205eb3940042a09ada667af4c8362ae429a02997eec4af133f2e73730b58d"

  url "https://github.com/easybar-app/easybar-native/releases/download/v0.4.0/EasyBarNative-0.4.0.zip"
  name "EasyBar Native"
  desc "Native macOS menu-bar frontend for EasyBarKit Lua widgets"
  homepage "https://github.com/easybar-app/easybar-native"

  depends_on formula: "lua"
  depends_on macos: :sonoma

  postflight do
    system "xattr", "-dr", "com.apple.quarantine", "#{appdir}/EasyBarNative.app"
  end

  app "EasyBarNative.app"
  binary "#{appdir}/EasyBarNative.app/Contents/MacOS/easybar-native", target: "easybar-native"

  zap trash: [
    "~/.config/easybar-native",
    "~/.local/share/easybar-native",
    "~/.local/state/easybar-native",
  ]
end
