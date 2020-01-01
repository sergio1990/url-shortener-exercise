# frozen_string_literal: true

require 'test_helper'
require 'add_link_service'
require 'link'
require 'links_repository'
require 'links_file_storage'
require 'tmpdir'

class AddLinkServiceTest < Minitest::Test
  ADD_BRAND_NEW_TEST_FILE = File.join(Dir.tmpdir, 'add_brand_new_test.csv')
  ADD_EXISTED_TEST_FILE = File.join(Dir.tmpdir, 'add_existed_test.csv')
  ADD_WITHOUT_SCHEME_TEST_FILE = File.join(Dir.tmpdir, 'add_without_scheme_test.csv')

  def setup
    File.delete(ADD_BRAND_NEW_TEST_FILE) if File.exist?(ADD_BRAND_NEW_TEST_FILE)
    File.delete(ADD_EXISTED_TEST_FILE) if File.exist?(ADD_EXISTED_TEST_FILE)
    File.delete(ADD_WITHOUT_SCHEME_TEST_FILE) if File.exist?(ADD_WITHOUT_SCHEME_TEST_FILE)
  end

  def test_adding_the_brand_new_link
    url = 'https://farmdrop.com'
    service = AddLinkService.new(init_repository(ADD_BRAND_NEW_TEST_FILE))

    result = service.call(url)

    assert_equal url, result.full_url
    refute result.short_prefix.nil?

    content = File.read(ADD_BRAND_NEW_TEST_FILE)

    assert content.include?(url)
    assert content.include?(result.short_prefix)
  end

  def test_adding_existed_url
    File.open(ADD_EXISTED_TEST_FILE, 'w') do |file|
      file.write('https://farmdrop.com,be795ae9')
    end
    url = 'https://farmdrop.com'
    service = AddLinkService.new(init_repository(ADD_EXISTED_TEST_FILE))

    assert File.readlines(ADD_EXISTED_TEST_FILE).size == 1

    result = service.call(url)

    assert_equal url, result.full_url
    assert_equal 'be795ae9', result.short_prefix

    assert File.readlines(ADD_EXISTED_TEST_FILE).size == 1
  end

  def test_adding_the_url_without_scheme
    url = 'farmdrop.com'
    service = AddLinkService.new(init_repository(ADD_WITHOUT_SCHEME_TEST_FILE))

    result = service.call(url)

    assert_equal "http://#{url}", result.full_url
    refute result.short_prefix.nil?

    content = File.read(ADD_WITHOUT_SCHEME_TEST_FILE)

    assert content.include?(result.full_url)
    assert content.include?(result.short_prefix)
  end

  private

  def init_repository(file_path)
    LinksRepository.new(
      LinksFileStorage.new(file_path)
    )
  end
end
