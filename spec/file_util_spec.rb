# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "FileUtil" do
  before(:each) do
    @my_clipping_path = "#{File.dirname(__FILE__)}/My Clippings.txt"
    @parser = Kcfu::FileUtil.new
    @import_clippings = KindleClippings::Parser.new.parse_file(File.expand_path(@my_clipping_path))
  end

  after(:each) do
    FileUtils.rm_r("#{Kcfu::FileUtil::ROOT_CLIPPING_FOLDER_NAME}")
  end

  it "should parse a 'My Clippings.txt' file and store the clipping to files separated by book_title" do
    book_titles = @import_clippings.map(&:book_title).uniq

    @parser.parse_file(File.expand_path(@my_clipping_path))

    book_titles.each do |title|
      expect(File.exists?("#{Kcfu::FileUtil::ROOT_CLIPPING_FOLDER_NAME}/#{title}.txt")).to eq(true)
    end
  end

  it "should paste the parsed clippings to files" do
    book_titles = ["The Help", "Freakonomics Rev Ed", "Coders at Work", "Twilight (The Twilight Saga, Book 1)", "Last Words", "The Unlikely Disciple: A Sinner's Semester at America's Holiest University", "Confessions of a Public Speaker", "Thirteen Reasons Why", "The Tipping Point: How Little Things Can Make a Big Difference", "Test"]

    purged_clippings = []

    @import_clippings.each do |clipping|
      existed_clipping = purged_clippings.select { |c| c.book_title == clipping.book_title && c.content == clipping.content && c.type == clipping.type }
      next unless existed_clipping.empty?
      purged_clippings << clipping
    end

    @parser.parse_file(File.expand_path(@my_clipping_path))

    parsed_clippings_count = book_titles.inject(0) do |count, title|
      parsed_clippings = KindleClippings::Parser.new.parse_file("#{Kcfu::FileUtil::ROOT_CLIPPING_FOLDER_NAME}/#{title}.txt")
      count + parsed_clippings.size
    end

    expect(purged_clippings.size).to eq(parsed_clippings_count)
  end

  it "should not add new clipping if clipping is already existed" do
    FileUtils.mkdir_p(Kcfu::FileUtil::ROOT_CLIPPING_FOLDER_NAME)

    File.open("#{Kcfu::FileUtil::ROOT_CLIPPING_FOLDER_NAME}/The Help.txt", 'w') do |file|
      clipping = <<EOF
The Help (Kathryn Stockett)
- Highlight Loc. 5444-45 | Added on Saturday, October 31, 2009, 09:25 AM

“Like living in Antarctica all my life and one day moving to Hawaii.”
==========
EOF
      file.write(clipping)
    end

    book_titles = ["The Help", "Freakonomics Rev Ed", "Coders at Work", "Twilight (The Twilight Saga, Book 1)", "Last Words", "The Unlikely Disciple: A Sinner's Semester at America's Holiest University", "Confessions of a Public Speaker", "Thirteen Reasons Why", "The Tipping Point: How Little Things Can Make a Big Difference", "Test"]

    purged_clippings = []

    @import_clippings.each do |clipping|
      existed_clipping = purged_clippings.select { |c| c.book_title == clipping.book_title && c.content == clipping.content && c.type == clipping.type }
      next unless existed_clipping.empty?
      purged_clippings << clipping
    end

    @parser.parse_file(File.expand_path(@my_clipping_path))

    parsed_clippings_count = book_titles.inject(0) do |count, title|
      parsed_clippings = KindleClippings::Parser.new.parse_file("#{Kcfu::FileUtil::ROOT_CLIPPING_FOLDER_NAME}/#{title}.txt")
      count + parsed_clippings.size
    end

    expect(purged_clippings.size).to eq(parsed_clippings_count)
  end
end
