# frozen_string_literal: true

require_relative "qr_code_scanner/version"
require_relative "qr_code_scanner/qr_code_scanner"

module QRCodeScanner
  def self.scan(...)
    Scanner.scan_file(...)
  end
end
