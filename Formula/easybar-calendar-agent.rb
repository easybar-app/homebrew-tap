class EasybarCalendarAgent < Formula
  desc "Calendar EventKit helper service for EasyBar"
  homepage "https://github.com/easybar-app/easybar"
  url "https://github.com/easybar-app/easybar/releases/download/v0.44.0/EasyBarCalendarAgent-0.44.0.zip"
  sha256 "bb50f4addc8aee5a9156d59071eede3a911c4a79ac41b357077deed86729c6ef"
  license "Apache-2.0"
  version "0.44.0"

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
