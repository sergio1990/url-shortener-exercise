# frozen_string_literal: true

class LinksRepository
  ShortPrefixIsAlreadyTakenError = Class.new(::StandardError)

  def initialize(storage)
    @storage = storage
    @links_hash = init_links_hash
  end

  def all
    links_hash.values
  end

  def get_by_short_prefix(short_prefix)
    links_hash[short_prefix]
  end

  def add(link)
    check_short_prefix_for_existence!(link.short_prefix)
    links_hash[link.short_prefix] = link
    storage.persist(links_hash)
  end

  private

  attr_reader :storage, :links_hash

  def check_short_prefix_for_existence!(short_prefix)
    return unless links_hash.key?(short_prefix)

    raise ShortPrefixIsAlreadyTakenError, "The short prefix `#{short_prefix}` has already been taken!"
  end

  def init_links_hash
    Hash[
      storage.load.map { |link| [link.short_prefix, link] }
    ]
  end
end
