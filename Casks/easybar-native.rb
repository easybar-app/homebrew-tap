cask "easybar-native" do
  version "0.3.3"
  sha256 "53b02603572d81e955294542f375baaa22363cdf946fdd98b2e14ab5386fb800"

  url "https://github.com/easybar-app/easybar-native/releases/download/v0.3.3/EasyBarNative-0.3.3.zip"
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
