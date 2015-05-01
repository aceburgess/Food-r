get '/events' do
	events = Event.all
	erb :"events/index" , locals: {events: events}
end

post '/event/create' do 
	event = Event.new(params[:event])
	return [500,"Couldn't create event #{params[:event][:title]}"] unless event.save
	redirect '/events'
end

get '/event/:id' do
	event = Event.find_by(id: params[:id])
	return [500,"Couldn't find event"] unless event
	erb :"events/show", locals: { event: event }
end

get '/event/update/:id' do
	event = Event.find_by(id: params[:id])
	erb :"events/edit" , locals: { event: event }
end

put '/event/:id' do
	event = Event.find_by(id: params[:id])	
	return [500,"Couldn't find event"] unless event
	event.update_attributes(params[:event])
	redirect '/events'
end

delete '/event/:id' do
	event = Event.find_by(id: params[:id])	
	return [500,"Couldn't find event"] unless event
	event.destroy
	redirect '/events'
end

