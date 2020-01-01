# frozen_string_literal: true

require 'digest'

class AddLinkService
  Result = Struct.new(:full_url, :short_prefix)

  def initialize(repository)
    @repository = repository
  end

  def call(url)
    link = init_link_to_add(url)
    persist(link)
    Result.new(link.full_url, link.short_prefix)
  end

  private

  attr_reader :repository

  def init_link_to_add(url)
    normalized_url = normalize_url(url)
    short_prefix = shorten_url(normalized_url)
    Link.new(normalized_url, short_prefix)
  end

  def persist(link)
    repository.add(link)
  rescue LinksRepository::ShortPrefixIsAlreadyTakenError
  end

  def normalize_url(url)
    url =~ /^https?/ ? url : "http://#{url}"
  end

  def shorten_url(url)
    Digest::MD5.hexdigest(url).slice(0..7)
  end
end
