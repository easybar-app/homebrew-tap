class EasybarNetworkAgent < Formula
  desc "Wi-Fi and network helper service for EasyBar"
  homepage "https://github.com/easybar-app/easybar"
  url "https://github.com/easybar-app/easybar/releases/download/v0.62.0/EasyBarNetworkAgent-0.62.0.zip"
  sha256 "ade14817f45dca0b5942c032a47a958aa64731dec5a8429704be09971a91b94c"
  license "Apache-2.0"
  version "0.62.0"

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
