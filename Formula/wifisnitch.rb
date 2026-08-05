class Wifisnitch < Formula
  desc "Background macOS Wi-Fi and network status agent with CLI access"
  homepage "https://github.com/gi8lino/wifi-snitch"
  url "https://github.com/gi8lino/wifi-snitch/releases/download/v0.0.73/WiFiSnitch-0.0.73.zip"
  sha256 "30cdff22a64175635d5e003ab00a397dc8adbe19440e5a852616b01a1f5ec7e9"
  license "Apache-2.0"
  version "0.0.73"

  depends_on macos: :sonoma

  def install
    libexec.install "WiFiSnitch.app"
    bin.install "wifisnitch"

    (var/"log/wifisnitch").mkpath
  end

  service do
    run [opt_libexec/"WiFiSnitch.app/Contents/MacOS/WiFiSnitch"]
    environment_variables PATH: std_service_path_env, LANG: "en_US.UTF-8"
    keep_alive true
    process_type :interactive
    working_dir HOMEBREW_PREFIX
    log_path var/"log/wifisnitch/wifisnitch.out.log"
    error_log_path var/"log/wifisnitch/wifisnitch.err.log"
  end

  test do
    assert_match "wifisnitch", shell_output("#{bin}/wifisnitch --help 2>&1")
  end
end
