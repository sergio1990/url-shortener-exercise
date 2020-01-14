# typed: false
# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?

require 'json'

require './lib/config'
require './lib/links_repository'
require './lib/links_file_storage'
require './lib/add_link_service'
require './lib/redirect_service'

config = Config.new(ENV.to_h)
storage = LinksFileStorage.new(config.storage_file_path, config.logger)
repository = LinksRepository.new(storage, config.logger)

error RedirectService::UrlNotFoundError do
  content_type :json
  status 404
  { errors: [env['sinatra.error'].message] }.to_json
end

error JSON::ParserError do
  content_type :json
  status 400
  { errors: [env['sinatra.error'].message] }.to_json
end

get '/' do
  'Hello world from API!'
end

post '/urls' do
  content_type :json
  request_payload = JSON.parse(request.body.read)
  url = request_payload['url'].to_s
  if url.empty?
    halt 422, { errors: ['The parameter `url` has to be filled!'] }.to_json
  end

  service = AddLinkService.new(repository)
  result = service.call(url)
  { short_url: "/#{result.short_prefix}", url: result.full_url }.to_json
end

get '/urls' do
  content_type :json
  repository.all.map(&:to_h).to_json
end

get '/redirect' do
  content_type :json
  short_prefix = params['short_prefix'].to_s
  if short_prefix.empty?
    status 422
    halt 422, { errors: ['The parameter `short_prefix` has to be filled!'] }.to_json
  end

  service = RedirectService.new(repository)
  result = service.call(short_prefix)
  redirect to(result.full_url), 301, {url: result.full_url}.to_json
end
