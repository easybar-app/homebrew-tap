class EasybarNetworkAgent < Formula
  desc "Wi-Fi and network helper service for EasyBar"
  homepage "https://github.com/easybar-app/easybar"
  url "https://github.com/easybar-app/easybar/releases/download/v0.64.2/EasyBarNetworkAgent-0.64.2.zip"
  sha256 "4778fd4ad1b023d769ad1edc766c3179f8f8545d1be83213f3d3ca6a4950b736"
  license "Apache-2.0"
  version "0.64.2"

  depends_on macos: :sonoma

  def install
    libexec.install "EasyBarNetworkAgent.app"
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
    assert_predicate libexec/"EasyBarNetworkAgent.app/Contents/MacOS/EasyBarNetworkAgent", :executable?
  end
end
