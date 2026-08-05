class EasybarCalendarAgent < Formula
  desc "Calendar EventKit helper service for EasyBar"
  homepage "https://github.com/gi8lino/easybar"
  url "https://github.com/gi8lino/easybar/releases/download/v0.37.0/EasyBarCalendarAgent-0.37.0.zip"
  sha256 "52683a50afbd73c570fab6b7283ed6f061bcceca7942e9c1958c359e17855b13"
  license "Apache-2.0"
  version "0.37.0"

  depends_on macos: :sonoma

  def install
    libexec.install "EasyBarCalendarAgent.app"
    system "xattr", "-dr", "com.apple.quarantine", libexec/"EasyBarCalendarAgent.app"
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
    assert_predicate libexec/"EasyBarCalendarAgent.app", :exist?
  end
end
