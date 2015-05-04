get '/users/create' do
  erb :'/users/new'
end

get '/users/index' do
  require_logged_in
  groups_in = logged_user.groups
  organized_groups = Group.where(organizer_id: logged_user.id)
  erb :"users/index", locals:{ groups: groups_in, organized_groups: organized_groups}
end

post '/signup' do
  new_user = User.new(user_params(params[:user]))
  if new_user.save
    session[:user_id] = new_user.id
    redirect "/users"
  else
    return[500, "Something was wrong with your user inputs"]
  end
end

get '/users' do
  require_logged_in
  users = User.all().order(:name)
  erb :'/users/all', locals: {users: users}
end

get '/users/:id' do |id|
  require_logged_in
  find_user = User.find(id)
  return [500, "That user does not exist"] unless find_user
  erb :'/users/show', locals: {find_user: find_user}
end

get '/users/:id/edit' do
  require_logged_in
  if params[:id].to_i == logged_user.id
    erb :'/users/edit'
  else
    "Stop trying to game the system"
  end
end

get '/users/:id/delete' do
  erb :'/users/confirm_delete'
end

delete '/users/:id/delete' do
  if logged_user.authenticate(params[:password])
    logged_user.destroy
    session.clear
    redirect '/'
  else
    redirect '/users?error=ua'
  end
end

put '/users/:id/update' do
  logged_user.update(name: params[:name], email: params[:email])
  if logged_user.authenticate(params[:current_password]) && (params[:newpassword1] == params[:newpassword2])
    logged_user.password=(params[:newpassword1])
  end
  redirect '/users?updated=true'
end