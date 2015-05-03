get '/events' do
	require_logged_in
	events = params[:search] ? Event.where([" lower(title) LIKE ? " ,"%#{params[:search].downcase}%"]) : Event.all
	erb :"events/index" , locals: {events: events}
end

get '/events/new' do
	require_logged_in
	groups = Group.where(organizer_id: logged_user.id)
	erb :"/events/add", locals: { groups: groups }
end

post '/event/create' do
	require_logged_in
	params[:event][:event_on] = DateTime.parse("#{params[:event_date]}", "#{params[:event_time]}")
	event = Event.new(params[:event])
	return [500,"Couldn't create event #{params[:event][:title]}"] unless event.save
	city, state, zip_code = location_hash(params).values
	redirect :"/events/select_restaurants/#{event.id}?city=#{city}&state=#{state}&zip_code=#{zip_code}"
end

get '/events/select_restaurants/:event_id' do
	require_logged_in
	event = Event.find(params[:event_id])
	return [500, "Couldn't find event"] unless event
	local_area = location_hash params
	local_restaurants = yelp_search( local_area )
	erb :"/events/select_restaurants", locals: { event: event, local_restaurants: local_restaurants, local_area: local_area}
end

post '/events/select_restaurants/:event_id' do
	require_logged_in
	local_area = location_hash params
	event = Event.find(params[:event_id])
	create_restaurants_and_votes params[:yelp_phone], local_area, event
	redirect :"/event/#{params[:event_id]}"
end

get '/event/:id' do
	require_logged_in
	event = Event.find_by(id: params[:id])
	return [500,"Couldn't find event"] unless event
	vote = Vote.find_by(user_id: logged_user.id, event_id: event.id)
	erb :"events/show", locals: { event: event , vote: vote}
end

get '/event/update/:id' do
	require_logged_in
	event = Event.find_by(id: params[:id])
	groups = Group.all
	erb :"events/edit" , locals: { event: event, action: "/event/#{event.id}",
	submit_label: "save", groups: groups }
end

put '/event/:id' do
	require_logged_in
	event = Event.find_by(id: params[:id])
	return [500,"Couldn't find event"] unless event
	event.update_attributes(params[:event])
	redirect "/events/select_restaurants/#{event.id}"
end

delete '/event/:id' do
	require_logged_in
	event = Event.find_by(id: params[:id])
	return [500,"Couldn't find event"] unless event
	event.destroy
	redirect '/events'
end
