Yelp.client.configure do |config|
  config.consumer_key = ENV['CONSUMER_KEY']
  config.consumer_secret = ENV['CONSUMER_SECRET']
  config.token = ENV['TOKEN']
  config.token_secret = ENV['TOKEN_SECRET']
end

def location_hash(params = {})
  city = params[:city]
  state = params[:state]
  zip_code = params[:zip_code]
  {city: city, state: state, zip_code: zip_code}
end

def convert_to_string(args = {})
  [args[:city], args[:state], args[:zip_code]].compact.join(', ')
end

def yelp(params = {})
  Yelp.client.search( convert_to_string(location_hash(params)) , {term: 'food'}).businesses
end