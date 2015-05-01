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
  users = User.all()
  erb :'/users/all', locals: {users: users}
end

get '/users/:id' do |id|
  current_user = User.find(id)
  return [500, "That user does not exist"] unless current_user
  erb :'/users/show', locals: {current_user: current_user}
end

get '/users/:id/settings' do |id|
  current_user = User.find(id)
  return [500, "That user does not exist"] unless current_user
   erb :'/users/edit', locals: {current_user: current_user}
end

post '/users/:id/delete' do |id|
  current_user = User.find(id)
  current_user.delete
end

post '/users/:id/update' do
  current_user = User.find_by(id: params[:id])
  current_user.update(name: params[:name], params[:email], params[:password])
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
