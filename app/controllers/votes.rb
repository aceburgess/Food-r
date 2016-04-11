#ZM: Name these id's correctly
post '/event/:e_id/restaurant/:r_id/vote' do
	
	votes_params = {user_id: logged_user.id, event_id: params[:e_id]}
	vote = Vote.find_by(votes_params)
	redirect "/event/#{params[:e_id]}?error=already_voted" if vote
	
	new_vote = Vote.new
	new_vote.restaurant_id = params[:r_id]
	new_vote.user = logged_user
	
	event = Event.find(params[:e_id])
	new_vote.event = event
	new_vote.save
	
	#All of this logic should be in the model, this is perfect for a Before_save Filter
	if !event.winner && event.check_winner
		event.winner = event.winning_id
		event.save
	end
	redirect "/event/#{event.id}"

end