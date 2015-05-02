get '/events' do
	events = Event.all
	erb :"events/index" , locals: {events: events}
end

get '/events/new' do
	groups = Group.all
	erb :"/events/add", locals: { groups: groups }
end

post '/event/create' do
	params[:event][:event_on] = DateTime.parse("#{params[:event_date]} #{params[:event_time]}")
	event = Event.new(params[:event])
	return [500,"Couldn't create event #{params[:event][:title]}"] unless event.save
	city = params[:city]
	state = params[:state]
	zip_code = params[:zip_code]
	redirect :"/events/select_restaurants/#{event.id}?city=#{city}&state=#{state}&zip_code=#{zip_code}"
end

get '/events/select_restaurants/:event_id' do
	event = Event.find(params[:event_id])
	return [500, "Couldn't find event"] unless event
	local_area = location_hash params
	local_restaurants = yelp_search( local_area )
	erb :"/events/select_restaurants", locals: { event: event, local_restaurants: local_restaurants, local_area: local_area}
end

post '/events/select_restaurants/:event_id' do
	local_area = location_hash params
	event = Event.find(params[:event_id])
	organizer = logged_user
	params[:yelp_phone].each do |name, phone|
		unless Restaurant.find_by(phone: phone)
			current_restaurant = yelp_search_by_phone phone
			new_restaurant = Restaurant.new
			new_restaurant.name = current_restaurant.name
			new_restaurant.business_id = current_restaurant.id
			new_restaurant.phone = current_restaurant.phone
			new_restaurant.url = current_restaurant.url
			new_restaurant.address = current_restaurant.location.address.first
			new_restaurant.location = convert_to_string local_area
			new_restaurant.picture_url = current_restaurant.image_url
			new_restaurant.save
			new_vote = Vote.new
			new_vote.restaurant_id = new_restaurant.id
			new_vote.user_id = organizer.id
			new_vote.event_id = event.id
			new_vote.save
		end
	end
	redirect :"/event/#{params[:event_id]}"
end

get '/event/:id' do
	event = Event.find_by(id: params[:id])
	return [500,"Couldn't find event"] unless event
	erb :"events/show", locals: { event: event }
end

get '/event/update/:id' do
	event = Event.find_by(id: params[:id])
	groups = Group.all
	erb :"events/edit" , locals: { event: event, action: "/event/#{event.id}",
	submit_label: "save", groups: groups }
end

put '/event/:id' do
	event = Event.find_by(id: params[:id])
	return [500,"Couldn't find event"] unless event
	event.update_attributes(params[:event])
	redirect '/events/select_restaurants/#{event.id}'
end

delete '/event/:id' do
	event = Event.find_by(id: params[:id])
	return [500,"Couldn't find event"] unless event
	event.destroy
	redirect '/events'
end

