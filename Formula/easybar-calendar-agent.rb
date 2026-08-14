class EasybarCalendarAgent < Formula
  desc "Calendar EventKit helper service for EasyBar"
  homepage "https://github.com/easybar-app/easybar"
  url "https://github.com/easybar-app/easybar/releases/download/v0.63.8/EasyBarCalendarAgent-0.63.8.zip"
  sha256 "36031418bcc30cbb763e6aa3c4ca5b31e140dbde29448fff18c917078e0d513b"
  license "Apache-2.0"
  version "0.63.8"

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
