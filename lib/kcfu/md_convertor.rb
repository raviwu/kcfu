require 'fileutils'
require 'kindleclippings'

module Kcfu
  class MdConvertor
    def parse_file(path)
      save_clipping_to_file(path, parser.parse_file(path))
    end

    private

    def parser
      @parser ||= KindleClippings::Parser.new
    end

    def location(clipping)
      return "Page #{clipping.page}" if clipping.page.size > 0
      return "Loc #{clipping.location}" if clipping.location.size > 0
    end

    def save_clipping_to_file(path, clippings)
      markdown_path = path.gsub("txt", "md")

      dir = File.dirname(markdown_path)
      FileUtils.mkdir_p(dir) unless File.directory?(dir)

      File.open(markdown_path, "w")

      File.open(markdown_path, "w") do |f|
        f.write("# #{clippings.first.book_title}\n\n")
        f.write("by #{clippings.first.author}\n\n") if clippings.first.author
        clippings.each do |clipping|
          f.write("*#{clipping.type}*\n\n") unless clipping.type == :Highlight
          f.write("> #{location(clipping)}\n")
          f.write("> \n")
          f.write("> #{clipping.content}\n\n")
        end
      end
    end
  end
end
