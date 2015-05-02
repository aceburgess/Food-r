get '/events' do
	events = Event.all
	erb :"events/index" , locals: {events: events}
end

get '/events/new' do
	groups = Group.all
	erb :"/events/add", locals: { groups: groups }
end

post '/event/create' do
	event = Event.new(params[:event])
	return [500,"Couldn't create event #{params[:event][:title]}"] unless event.save
	redirect '/events/select_restaurants/#{event.id}'
end

get 'events/select_restaurants/:event_id' do
	event = Event.find(params[:event_id])
	return [500, "Couldn't find event"] unless event
	city = params[:city]
	state = params[:state]
	zip_code = params[:zip_code]

end

post 'events/select_restaurants/' do

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
	submit_label: submit_label, groups: groups }
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

