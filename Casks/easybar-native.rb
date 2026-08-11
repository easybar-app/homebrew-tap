cask "easybar-native" do
  version "0.3.2"
  sha256 "dc96aed4a930277b1ddb6f8895f0f6309ea0359d9c22d8341cba0740f71e59a9"

  url "https://github.com/easybar-app/easybar-native/releases/download/v0.3.2/EasyBarNative-0.3.2.zip"
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
