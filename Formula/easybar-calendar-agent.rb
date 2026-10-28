class EasybarCalendarAgent < Formula
  desc "Calendar EventKit helper service for EasyBar"
  homepage "https://github.com/easybar-app/easybar"
  url "https://github.com/easybar-app/easybar/releases/download/v0.64.4/EasyBarCalendarAgent-0.64.4.zip"
  sha256 "e4d056d21df7fdcd4044865336cc02fe766134803bcc315d7a20f6f669d4196e"
  license "Apache-2.0"
  version "0.64.4"

  depends_on macos: :sonoma

  def install
    libexec.install "EasyBarCalendarAgent.app"
    (var/"log/easybar").mkpath
  end

  service do
    run [opt_libexec/"EasyBarCalendarAgent.app/Contents/MacOS/EasyBarCalendarAgent"]
    environment_variables PATH: std_service_path_env, LANG: "en_US.UTF-8"
    keep_alive successful_exit: false
    process_type :interactive
    working_dir HOMEBREW_PREFIX
    log_path var/"log/easybar/calendar-agent.out.log"
    error_log_path var/"log/easybar/calendar-agent.err.log"
  end

  test do
    assert_predicate libexec/"EasyBarCalendarAgent.app/Contents/MacOS/EasyBarCalendarAgent", :executable?
  end
end
