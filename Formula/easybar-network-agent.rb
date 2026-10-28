class EasybarNetworkAgent < Formula
  desc "Wi-Fi and network helper service for EasyBar"
  homepage "https://github.com/easybar-app/easybar"
  url "https://github.com/easybar-app/easybar/releases/download/v0.64.5/EasyBarNetworkAgent-0.64.5.zip"
  sha256 "498761ec071d387b1e2723393c5665ca67875a6cb0cae1cfa82b286f84e2baf0"
  license "Apache-2.0"
  version "0.64.5"

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
