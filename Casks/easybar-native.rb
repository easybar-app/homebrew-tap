cask "easybar-native" do
  version "0.3.1"
  sha256 "53a2cd8dcf6d44d36c4a65b4b35cadb7933704497648f62517d485799d64f1fb"

  url "https://github.com/easybar-app/easybar-native/releases/download/v0.3.1/EasyBarNative-0.3.1.zip"
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
