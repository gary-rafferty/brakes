require 'sinatra/base'
require 'exceptional'

class Brakes < Sinatra::Base

  #Store API key in .env locally, and config vars on Heroku
  set :exceptional_api_key, ENV['EXCEPTIONAL_API_KEY']

  #Enable Exceptional middleware, use our API key
  use Rack::Exceptional, settings.exceptional_api_key

  set :raise_errors, true

  #GET /
  #Raise error and set some custom context for Exceptional
  get '/' do
    Exceptional.context(:when => Time.now, :message => 'This is a custom message')
    raise 'Error raised on GET /'
  end

  run! if app_file == $0
end
