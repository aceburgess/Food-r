get '/groups' do
  groups = Group.all
  erb :"groups/index", locals: {groups: groups}
end

post '/group' do
  params[:admin_id] = session[:user_id]
  params[:organizer_id] = session[:user_id]
  new_group = Group.create(params)
  new_group.members = params[:members].split(",").map do |name|
    User.find_by(name: name.strip)
  end
  new_group.save
end

get '/group/:id' do
  group = Group.find_by(id: params[:id])
  return [500, "Couldn't Find Group"] unless group
end

put '/group/:id' do
  group = Group.find_by(id: params[:id])
  return [500, "Couldn't Find Group"] unless group
  group.update_attributes(params[:event])
  redirect '/groups'
end

delete '/group/:id' do
  group = Group.find_by(id: params[:id])
  return [500, "Couldn't Find Group"] unless group
  group.delete
  redirect '/groups'
end
