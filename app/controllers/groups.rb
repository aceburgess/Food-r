get '/groups' do
  require_logged_in
  groups = Group.all
  erb :'groups/index', locals: {groups: groups}
end

get '/groups/new' do
  require_logged_in
  users = User.all

  #ZM: wat?
  users_json = users.map{|user| Hash[id: user.id, name: user.name , email: user.email]}.to_json
  
  erb :'groups/new', locals: { users: users_json}
end

post '/groups' do

  new_group = Group.create(name: params[:name], admin_id: logged_user.id, organizer_id: logged_user.id)
  member_objects = []

  #ZM: Do not live modify the params hash 
  params[:members].delete("")

  #ZM: This will throw an exepction if the ID is not found
  params[:members].each do |id|
    member = User.find(id)
    member_objects << member if member
  end

  return [500, "You Must Add Valid Members to Your Group"] unless member_objects.length > 0

  new_group.members = member_objects

  #ZM: What Happens if it does not save?
  new_group.save

  redirect '/groups'
end

get '/group/:id' do
  require_logged_in
  group = Group.find_by(id: params[:id])
  return [500, "Couldn't Find Group"] unless group

  erb :'groups/show', locals: {group: group}
end

get '/group/edit/:id' do
  require_logged_in
  current_user = User.find_by(id: session[:user_id])
  group = Group.find_by(id: params[:id])
  return [500, "Couldn't Find Group."] unless group
  return [403, "You don't have access to this."] unless group.admin_id == current_user.id

  members_string = ""

  #ZM: This Feels funky.. You can probably just use a map and join on ", "
  group.members.each do |member|
    members_string += member.name
    members_string += ", " unless member == group.members.last
  end

  erb :'groups/edit', locals: {group: group, members_string: members_string}
end

put '/group/:id' do
  group = Group.find_by(id: params[:id])
  return [500, "Couldn't Find Group"] unless group

  group.name = params[:name]

  split_string = params[:members].split(",").each {|member| member.strip!}

  member_objects = []
  
  #ZM: This Logic feels very anti-pattern. Let's see if we can make it better
  split_string.each do |name|
    member = User.find_by(name: name)
    member_objects << member if member
  end

  group.members = member_objects
  group.save

  redirect "/group/#{group.id}"
end

delete '/group/:id' do
  group = Group.find_by(id: params[:id])
  return [500, "Couldn't Find Group"] unless group
  group.delete
  redirect '/groups'
end
