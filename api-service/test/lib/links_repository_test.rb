# frozen_string_literal: true

require 'test_helper'
require 'links_repository'
require 'link'

class LinksRepositoryTest < Minitest::Test
  def test_all
    repository = init_repository
    all_links = repository.all
    assert_equal 2, all_links.count
    link = all_links.first
    assert link.is_a?(Link)
  end

  def test_get_by_short_prefix_when_it_exists
    repository = init_repository
    link = repository.get_by_short_prefix('farmdrop')
    refute link.nil?
    assert link.is_a?(Link)
    assert 'https://farmdrop.com', link.full_url
  end

  def test_get_by_short_prefix_when_it_does_not_exist
    repository = init_repository
    link = repository.get_by_short_prefix('youtube')
    assert link.nil?
  end

  def test_add_the_uniq_link
    new_link = Link.new('https://youtube.com', 'youtube')
    storage_mock = init_storage
    storage_mock.expect(:persist, nil) do |arg|
      arg.is_a?(Hash) && (arg.count == 3)
    end

    repository = init_repository(storage_mock)

    assert_equal 2, repository.all.count
    repository.add(new_link)
    assert_equal 3, repository.all.count

    storage_mock.verify
  end

  def test_add_the_link_with_already_existing_short_prefix
    new_link = Link.new('https://youtube.com', 'farmdrop')
    repository = init_repository

    assert_raises LinksRepository::ShortPrefixIsAlreadyTakenError do
      repository.add(new_link)
    end
  end

  private

  def init_repository(storage = nil)
    LinksRepository.new(storage || init_storage)
  end

  def init_storage
    storage = Minitest::Mock.new
    def storage.load
      {
        'farmdrop' => Link.new('https://farmdrop.com', 'farmdrop'),
        'google' => Link.new('https://google.com', 'google')
      }
    end
    storage
  end
end
