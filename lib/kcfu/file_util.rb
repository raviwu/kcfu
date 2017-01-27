require 'kindleclippings'
require 'fileutils'

module Kcfu
  class FileUtil
    ROOT_CLIPPING_FOLDER_NAME = 'kindle_clippings'

    def parse_file(path, options = {})
      parser.parse_file(path).each do |import_clipping|
        existed_clippings = parse_export_file(export_file_path(import_clipping))

        next unless not_clipped_before?(existed_clippings, import_clipping)

        existed_clippings << import_clipping

        sorted_clippings = existed_clippings.sort { |x, y| x.added_on <=> y.added_on }

        save_clipping_to_file(export_file_path(import_clipping), sorted_clippings)
      end

      conver_markdown(path) if options[:convert] == :markdown
    end

    private

    def conver_markdown(path)
      book_titles = parser.parse_file(path).map(&:book_title).uniq
      book_titles.each { |title| markdown_converter.parse_file("#{ROOT_CLIPPING_FOLDER_NAME}/#{title}.txt") }
    end

    def markdown_converter
      @markdown_converter = MdConvertor.new
    end

    def parser
      @parser ||= KindleClippings::Parser.new
    end

    def export_file_path(clipping)
      "#{ROOT_CLIPPING_FOLDER_NAME}/#{clipping.book_title}.txt"
    end

    def not_clipped_before?(existed_clippings, import_clipping)
      existed_clippings.select do |clipping|
        clipping.content == import_clipping.content && clipping.type == import_clipping.type
      end.empty?
    end

    def seperator
      "\r\n" + "=" * 10 + "\r\n"
    end

    def parse_export_file(path)
      dir = File.dirname(path)
      FileUtils.mkdir_p(dir) unless File.directory?(dir)

      File.open(path, 'a')

      parser.parse_file(path)
    end

    def save_clipping_to_file(path, clippings)
      File.open(path, "w") do |f|
        clippings.each do |clipping|
          f.write(clipping)
          f.write(seperator)
        end
      end
    end
  end
end
