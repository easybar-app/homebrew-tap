cask "easybar-native" do
  version "0.3.0"
  sha256 "767d6c80fe400e907d771630e236baccc4e8b727d6e0ddbed3bf14fe15235130"

  url "https://github.com/easybar-app/easybar-native/releases/download/v0.3.0/EasyBarNative-0.3.0.zip"
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
