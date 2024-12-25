# frozen_string_literal: true

require "nodo"

module QRCodeScanner
  class Scanner < Nodo::Core
    require fs: "node:fs"
    require path: "node:path"

    require jsQR: "jsqr"
    require pdfToPng: "pdf-to-png-converter"
    require imagedata: "@andreekeberg/imagedata"

    def self.scan_file(path)
      if path.end_with?(".pdf")
        new.parse_pdf(path)
      else
        [new.parse_image(path)]
      end
    end

    function :parse_image, <<~JS
      (imagePath) => {
        const { data, width, height } = imagedata.getSync(imagePath)

        return jsQR(data, width, height)?.data
      }
    JS

    function :parse_pdf, <<~JS
      async (pdfPath) => {
        const filename = path.basename(pdfPath)

        const pages = await pdfToPng.pdfToPng(pdfPath, { // The function accepts PDF file path or a Buffer
          disableFontFace: false, // When `false`, fonts will be rendered using a built-in font renderer that constructs the glyphs with primitive path commands. Default value is true.
          // useSystemFonts: false, // When `true`, fonts that aren't embedded in the PDF document will fallback to a system font. Default value is false.
          // enableXfa: false, // Render Xfa forms if any. Default value is false.
          viewportScale: 3.0, // The desired scale of PNG viewport. Default value is 1.0.
          outputFolder: 'tmp/qr_code_scanner', // Folder to write output PNG files. If not specified, PNG output will be available only as a Buffer content, without saving to a file.
          outputFileMaskFunc: (page) => `${filename}_page_${page}.png`, // Function to generate custom output filenames. Example: (pageNum) => `page_${pageNum}.png`
          // pdfFilePassword: 'pa$$word', // Password for encrypted PDF.
          // pagesToProcess: [1, 3, 11], // Subset of pages to convert (first page = 1), other pages will be skipped if specified.
          // strictPagesToProcess: false, // When `true`, will throw an error if specified page number in pagesToProcess is invalid, otherwise will skip invalid page. Default value is false.
          // verbosityLevel: 0 // Verbosity level. ERRORS: 0, WARNINGS: 1, INFOS: 5. Default value is 0.
        })

        const result = pages.map(page => parse_image(page.path))

        pages.map(page => fs.unlinkSync(page.path)) // cleanup generated images

        return result.filter(result => result)
      }
    JS
  end
end
