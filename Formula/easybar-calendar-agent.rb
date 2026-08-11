class EasybarCalendarAgent < Formula
  desc "Calendar EventKit helper service for EasyBar"
  homepage "https://github.com/easybar-app/easybar"
  url "https://github.com/easybar-app/easybar/archive/refs/tags/v0.61.0.tar.gz"
  sha256 "1f4992ed04cbd75d184e609c05349677c8db29f69b011af384efdd5850e40196"
  license "Apache-2.0"
  version "0.6.1"

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
