class EasybarNetworkAgent < Formula
  desc "Wi-Fi and network helper service for EasyBar"
  homepage "https://github.com/easybar-app/easybar"
  url "https://github.com/easybar-app/easybar/releases/download/v0.53.1/EasyBarNetworkAgent-0.53.1.zip"
  sha256 "f2c10f0db2935872ec63af072d849e072a2e03bd33a89263f53f0c922ffa9db5"
  license "Apache-2.0"
  version "0.53.1"

  depends_on macos: :sonoma

  def install
    libexec.install "EasyBarNetworkAgent.app"
    system "xattr", "-dr", "com.apple.quarantine", libexec/"EasyBarNetworkAgent.app"
    (var/"log/easybar").mkpath
  end

  service do
    run [opt_libexec/"EasyBarNetworkAgent.app/Contents/MacOS/EasyBarNetworkAgent"]
    environment_variables PATH: std_service_path_env, LANG: "en_US.UTF-8"
    keep_alive successful_exit: false
    process_type :interactive
    working_dir HOMEBREW_PREFIX
    log_path var/"log/easybar/network-agent.out.log"
    error_log_path var/"log/easybar/network-agent.err.log"
  end

  test do
    assert_predicate libexec/"EasyBarNetworkAgent.app", :exist?
  end
end
