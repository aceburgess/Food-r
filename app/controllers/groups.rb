get '/groups' do
  groups = Group.all
  erb :'groups/index', locals: {groups: groups}
end

get '/groups/new' do
  erb :'groups/new'
end

post '/groups' do
  new_group = Group.create(name: params[:name], admin_id: session[:user_id], organizer_id: session[:user_id])

  split_string = params[:members].split(",").each {|member| member.strip!}

  member_objects = []
  split_string.each do |name|
    member = User.find_by(name: name)
    member_objects << member if member
  end

  new_group.members = member_objects
  new_group.save

  redirect '/groups'
end

get '/group/:id' do
  group = Group.find_by(id: params[:id])
  return [500, "Couldn't Find Group"] unless group

  erb :'groups/show', locals: {group: group}
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
