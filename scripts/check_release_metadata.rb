#!/usr/bin/env ruby
# frozen_string_literal: true

# Validates that every tap artifact names one coherent release. Homebrew derives
# Formula versions from URLs, while Casks declare them separately, so both forms
# need an explicit repository-level contract check.

ROOT = File.expand_path("..", __dir__)
SEMVER = /\A\d+\.\d+\.\d+(?:[-+][0-9A-Za-z.-]+)?\z/
SHA256 = /\A[0-9a-f]{64}\z/

def fail_with(path, message)
  warn "#{path}: #{message}"
  exit 1
end

def quoted_value(contents, key)
  contents[/^\s*#{Regexp.escape(key)}\s+"([^"]+)"/, 1]
end

artifact_paths = Dir.glob(File.join(ROOT, "{Casks,Formula}", "*.rb")).sort
abort "no Homebrew artifacts found" if artifact_paths.empty?

artifact_paths.each do |path|
  contents = File.read(path)
  relative_path = path.delete_prefix("#{ROOT}/")
  url = quoted_value(contents, "url")
  sha256 = quoted_value(contents, "sha256")

  fail_with(relative_path, "missing release URL") unless url
  fail_with(relative_path, "missing SHA-256") unless sha256
  fail_with(relative_path, "invalid SHA-256") unless SHA256.match?(sha256)

  if relative_path.start_with?("Casks/")
    version = quoted_value(contents, "version")
    fail_with(relative_path, "missing Cask version") unless version
    fail_with(relative_path, "invalid Cask version #{version.inspect}") unless SEMVER.match?(version)
    fail_with(relative_path, "URL must interpolate the Cask version tag") unless url.include?('v#{version}')
    fail_with(relative_path, "URL must interpolate the Cask version in its asset name") unless url.include?('#{version}')
  else
    match = url.match(%r{/releases/download/v(?<tag>[^/]+)/[^/]+-(?<asset>[^/]+)\.zip\z})
    fail_with(relative_path, "URL must contain a versioned GitHub release asset") unless match
    fail_with(relative_path, "release tag and asset version differ") unless match[:tag] == match[:asset]
    fail_with(relative_path, "invalid Formula release version #{match[:tag].inspect}") unless SEMVER.match?(match[:tag])
  end
end

puts "Validated #{artifact_paths.length} Homebrew release metadata artifact(s)."
