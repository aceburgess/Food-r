post 'event/:e_id/restaurant/:r_id/vote' do
	votes_params = {user_id: session[:user_id], event_id: params[:e_id]}
	vote = Vote.find_by(votes_params)
	redirect '/votes?error=av' if vote
	votes_params[:restaurant] = params[:r_id]
	vote = Vote.create(votes_params)
	redirect '/votes'
end

get '/votes' do
	erb :"votes/show", locals: { message: params[:error]}
end