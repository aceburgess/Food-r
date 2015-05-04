post '/session' do
  current_user = User.find_by(email: params[:email])
  if (current_user && current_user.authenticate(params[:password]))
    session[:user_id] = current_user.id
    redirect '/events'
  else
    redirect '/?error=ua'
  end
end

post '/session/end' do
  session[:user_id] = nil
  redirect '/'
end
