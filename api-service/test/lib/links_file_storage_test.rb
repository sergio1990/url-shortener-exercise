# frozen_string_literal: true

require 'test_helper'
require 'links_file_storage'
require 'link'
require 'tmpdir'

class LinksFileStorageTest < Minitest::Test
  def test_load_when_file_does_not_exists
    file_path = File.join(Dir.tmpdir, 'unexisted_file.csv')
    storage = LinksFileStorage.new(file_path)
    links = storage.load
    assert links.empty?
  end

  def test_load_when_file_exists_and_it_is_not_empty
    file_path = File.join(Dir.tmpdir, 'test_load.csv')
    File.open(file_path, 'w') { |file| file.write('https://farmdrop.com,farmdrop') }
    storage = LinksFileStorage.new(file_path)

    links = storage.load
    assert links.any?

    link = links.first
    assert_equal 'farmdrop', link.short_prefix
    assert_equal 'https://farmdrop.com', link.full_url
  end

  def test_persist
    file_path = File.join(Dir.tmpdir, 'test_persist.csv')
    storage = LinksFileStorage.new(file_path)

    storage.persist([Link.new('https://google.com', 'google')])

    content = File.read(file_path)

    assert content.include?('https://google.com,google')
  end
end
