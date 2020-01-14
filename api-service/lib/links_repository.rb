# typed: false
# frozen_string_literal: true

require 'logger'

class LinksRepository
  ShortPrefixIsAlreadyTakenError = Class.new(::StandardError)

  def initialize(storage, logger = Logger.new(nil))
    @storage = storage
    @logger = logger
    @links_hash = init_links_hash
    @semaphore = Mutex.new
  end

  def all
    @semaphore.synchronize do
      links_hash.values
    end
  end

  def get_by_short_prefix(short_prefix)
    @semaphore.synchronize do
      logger.info("Trying to get URL for the short prefix `#{short_prefix}`")
      links_hash[short_prefix]
    end
  end

  def add(link)
    @semaphore.synchronize do
      logger.info("Trying to add a new link entry `#{link.to_h}`")
      check_short_prefix_for_existence!(link.short_prefix)
      links_hash[link.short_prefix] = link
      storage.persist(links_hash.values)
    end
  end

  private

  attr_reader :storage, :links_hash, :logger

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
