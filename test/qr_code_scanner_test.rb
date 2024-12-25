# frozen_string_literal: true

require "test_helper"

class TestQRCodeScanner < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::QRCodeScanner::VERSION
  end

  def test_text
    assert_equal ["hello world"], QRCodeScanner.scan("#{Dir.pwd}/test/fixtures/hello_world.png")
  end

  def test_url
    assert_equal ["https://github.com/marcoroth"], QRCodeScanner.scan("#{Dir.pwd}/test/fixtures/github_marcoroth.png")
  end

  def test_scan_qr_codes_from_pdfs_and_pngs
    tests_mapping = {
      "#{Dir.pwd}/test/fixtures/muster-qr-zahlteile-de/*.jpg" => "#{Dir.pwd}/test/fixtures/datenschema-zu-mustern-txt-dateien-de/*.txt",
      "#{Dir.pwd}/test/fixtures/muster-qr-zahlteile-en/*.jpg" => "#{Dir.pwd}/test/fixtures/datenschema-zu-mustern-txt-dateien-en/*.txt",
      "#{Dir.pwd}/test/fixtures/muster-qr-zahlteile-de/pdf/*.pdf" => "#{Dir.pwd}/test/fixtures/datenschema-zu-mustern-txt-dateien-de/*.txt",
      "#{Dir.pwd}/test/fixtures/muster-qr-zahlteile-en/pdf/*.pdf" => "#{Dir.pwd}/test/fixtures/datenschema-zu-mustern-txt-dateien-en/*.txt"
    }

    tests = tests_mapping.flat_map do |images_path, texts_path|
      images = Dir[images_path]
      texts = Dir[texts_path]

      images.zip(texts)
    end

    tests.each do |image_path, text_path|
      print "."
      result = QRCodeScanner.scan(image_path)
      text = File.read(text_path).gsub("\r", "").strip

      assert_equal text, result.first.to_s
    end
  end
end
