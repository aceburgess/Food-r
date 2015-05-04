helpers do

  def logged_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def require_logged_in
    redirect('/?error=ua') unless is_authenticated?
  end

  def is_authenticated?
    !!session[:user_id]
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

end
