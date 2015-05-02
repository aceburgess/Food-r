get '/users/create' do
  erb :'/users/new'
end

post '/users' do
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
  users = User.all()
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

delete '/users/:id/delete' do
  logged_user.destroy
  redirect '/users'
end

put '/users/:id/update' do
  logged_user.update(params[:user])
end

# Validation for the creation of a new User object
def user_params(params)
  params.each_with_object({}) do |(key,value), obj|
    obj[key] = value if valid_params.include?(key.to_sym)
  end
end

def valid_params
  [:name, :email, :password]
end
