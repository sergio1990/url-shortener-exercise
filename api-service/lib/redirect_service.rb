# typed: true
# frozen_string_literal: true

class RedirectService
  Result = Struct.new(:full_url)
  UrlNotFoundError = Class.new(::StandardError)

  def initialize(repository)
    @repository = repository
  end

  def call(short_prefix)
    link = repository.get_by_short_prefix(short_prefix)
    return Result.new(link.full_url) if link

    raise UrlNotFoundError, "The URL associated with the short prefix `#{short_prefix}` does not exist!"
  end

  private

  attr_reader :repository
end
