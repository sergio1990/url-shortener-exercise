# frozen_string_literal: true

require 'sinatra'

get '/' do
  'Hello world from API!'
end

get '/redirect' do
  "Redirecting for params `#{params}`"
end
