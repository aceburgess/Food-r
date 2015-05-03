get '/' do
 	if !is_authenticated?
  		erb :index
	else
		redirect '/users/index'
	end
end

get '/login' do
  erb :login
end

