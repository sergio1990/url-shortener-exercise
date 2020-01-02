# frozen_string_literal: true

require 'sinatra'
require 'json'

require './lib/config'
require './lib/links_repository'
require './lib/links_file_storage'
require './lib/add_link_service'
require './lib/redirect_service'

config = Config.new(ENV)
storage = LinksFileStorage.new(config.storage_file_path, config.logger)
repository = LinksRepository.new(storage, config.logger)

get '/' do
  'Hello world from API!'
end

post '/urls' do
  content_type :json
  begin
    request_payload = JSON.parse(request.body.read)
    url = request_payload['url']
    if url.nil? || url == ''
      status 422
      { errors: ['The parameter `url` has to be filled!'] }.to_json
    else
      service = AddLinkService.new(repository)
      result = service.call(request_payload['url'])
      { short_url: "/#{result.short_prefix}", url: result.full_url }.to_json
    end
  rescue JSON::ParserError
    status 400
    { errors: ['The body has to be a valid JSON object!'] }.to_json
  end
end

get '/redirect' do
  begin
    short_prefix = params['short_prefix'].to_s
    if short_prefix == ''
      status 422
      { errors: ['The parameter `short_prefix` has to be filled!'] }.to_json
    else
      service = RedirectService.new(repository)
      result = service.call(short_prefix)
      redirect to(result.full_url), 301
    end
  rescue RedirectService::UrlNotFoundError => e
    content_type :json
    status 404
    { errors: [e.message] }.to_json
  end
end
