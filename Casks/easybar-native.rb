cask "easybar-native" do
  version "0.2.1"
  sha256 "1ab61e6dae01e94838784b10442631f69979369533fa835f7924cc3fcc1a82a1"

  url "https://github.com/easybar-app/easybar-native/releases/download/v0.2.1/EasyBarNative-0.2.1.zip"
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
