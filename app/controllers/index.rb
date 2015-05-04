get '/' do
  #zm: HighFive
 	is_authenticated? ? (redirect '/users/index') : (erb :index)
end

get '/login' do
  erb :login
end

