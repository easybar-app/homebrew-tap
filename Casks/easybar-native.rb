cask "easybar-native" do
  version "0.4.1"
  sha256 "efa4e1dc18cb7312d30bdb051760c0cb9371ff5efb8954528f655959a060e18a"

  url "https://github.com/easybar-app/easybar-native/releases/download/v0.4.1/EasyBarNative-0.4.1.zip"
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
