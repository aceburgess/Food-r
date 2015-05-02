get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/login' do
  erb :login
end

