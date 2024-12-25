# frozen_string_literal: true

require_relative "lib/qr_code_scanner/version"

Gem::Specification.new do |spec|
  spec.name = "qr_code_scanner"
  spec.version = QRCodeScanner::VERSION
  spec.authors = ["Marco Roth"]
  spec.email = ["marco.roth@intergga.ch"]

  spec.summary = "A Ruby Gem for scanning QR-Codes from documents."
  spec.description = spec.summary
  spec.homepage = "https://github.com/marcoroth/qr_code_scanner"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["rubygems_mfa_required"] = "true"
  spec.metadata["source_code_uri"] = "https://github.com/marcoroth/qr_code_scanner"
  spec.metadata["changelog_uri"] = "https://github.com/marcoroth/qr_code_scanner/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "nodo"
end
