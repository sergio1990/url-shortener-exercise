# typed: true
# frozen_string_literal: true

require 'test_helper'
require 'redirect_service'

class RedirectServiceTest < Minitest::Test
  TEST_FILE = TestFileUtils.tmp_file_path('redirect_service_test.csv')

  def setup
    TestFileUtils.create_file_with_content(
      TEST_FILE,
      'https://farmdrop.com,farmdrop'
    )
    @service = RedirectService.new(init_repository(TEST_FILE))
  end

  def test_when_there_is_an_entry_for_a_given_short_prefix
    result = service.call('farmdrop')

    assert_equal 'https://farmdrop.com', result.full_url
  end

  def test_when_a_given_short_prefix_does_not_exist
    assert_raises RedirectService::UrlNotFoundError do
      result = service.call('abc123')
    end
  end

  private

  attr_reader :service

  def init_repository(file_path)
    LinksRepository.new(
      LinksFileStorage.new(file_path)
    )
  end
end
