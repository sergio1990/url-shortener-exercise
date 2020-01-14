# typed: true
# frozen_string_literal: true

require 'test_helper'
require 'links_file_storage'
require 'link'

class LinksFileStorageTest < Minitest::Test
  def setup
    TestFileUtils.cleanup_tmp_folder
  end

  def test_load_when_file_does_not_exists
    file_path = TestFileUtils.tmp_file_path('unexisted_file.csv')
    storage = LinksFileStorage.new(file_path)
    links = storage.load
    assert links.empty?
  end

  def test_load_when_file_exists_and_it_is_not_empty
    file_path = TestFileUtils.tmp_file_path('test_load.csv')
    TestFileUtils.create_file_with_content(
      file_path,
      'https://farmdrop.com,farmdrop'
    )
    storage = LinksFileStorage.new(file_path)

    links = storage.load
    assert links.any?

    link = links.first
    assert_equal 'farmdrop', link.short_prefix
    assert_equal 'https://farmdrop.com', link.full_url
  end

  def test_persist
    file_path = TestFileUtils.tmp_file_path('test_persist.csv')
    storage = LinksFileStorage.new(file_path)

    storage.persist([Link.new('https://google.com', 'google')])

    content = TestFileUtils.read_content(file_path)

    assert content.include?('https://google.com,google')
  end
end
