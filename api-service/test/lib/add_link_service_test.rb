# frozen_string_literal: true

require 'test_helper'
require 'add_link_service'
require 'link'
require 'links_repository'
require 'links_file_storage'

class AddLinkServiceTest < Minitest::Test
  ADD_BRAND_NEW_TEST_FILE = TestFileUtils.tmp_file_path('add_brand_new_test.csv')
  ADD_EXISTED_TEST_FILE = TestFileUtils.tmp_file_path('add_existed_test.csv')
  ADD_WITHOUT_SCHEME_TEST_FILE = TestFileUtils.tmp_file_path('add_without_scheme_test.csv')

  def setup
    TestFileUtils.cleanup_tmp_folder
  end

  def test_adding_the_brand_new_link
    url = 'https://farmdrop.com'
    service = AddLinkService.new(init_repository(ADD_BRAND_NEW_TEST_FILE))

    result = service.call(url)

    assert_equal url, result.full_url
    refute result.short_prefix.nil?

    content = TestFileUtils.read_content(ADD_BRAND_NEW_TEST_FILE)

    assert content.include?(url)
    assert content.include?(result.short_prefix)
  end

  def test_adding_existed_url
    TestFileUtils.create_file_with_content(
      ADD_EXISTED_TEST_FILE,
      'https://farmdrop.com,be795ae9'
    )
    url = 'https://farmdrop.com'
    service = AddLinkService.new(init_repository(ADD_EXISTED_TEST_FILE))

    assert TestFileUtils.amount_of_lines(ADD_EXISTED_TEST_FILE) == 1

    result = service.call(url)

    assert_equal url, result.full_url
    assert_equal 'be795ae9', result.short_prefix

    assert TestFileUtils.amount_of_lines(ADD_EXISTED_TEST_FILE) == 1
  end

  def test_adding_the_url_without_scheme
    url = 'farmdrop.com'
    service = AddLinkService.new(init_repository(ADD_WITHOUT_SCHEME_TEST_FILE))

    result = service.call(url)

    assert_equal "http://#{url}", result.full_url
    refute result.short_prefix.nil?

    content = TestFileUtils.read_content(ADD_WITHOUT_SCHEME_TEST_FILE)

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
