# frozen_string_literal: true

require 'minitest/autorun'
require 'tmpdir'
require 'fileutils'

module TestFileUtils
  TMP_FOLDER = File.join(Dir.tmpdir, 'url-shortener').freeze

  module_function

  def setup_tmp_folder
    if Dir.exist?(TMP_FOLDER)
      cleanup_tmp_folder
    else
      Dir.mkdir(TMP_FOLDER)
    end
  end

  def cleanup_tmp_folder
    FileUtils.rm_rf(Dir[File.join(TMP_FOLDER, '*')])
  end

  def tmp_file_path(file_name)
    File.join(TMP_FOLDER, file_name)
  end

  def read_content(file_path)
    File.read(file_path)
  end

  def amount_of_lines(file_path)
    File.readlines(file_path).size
  end

  def create_file_with_content(file_path, content)
    File.open(file_path, 'w') do |file|
      file.write(content)
    end
  end
end

TestFileUtils.setup_tmp_folder
