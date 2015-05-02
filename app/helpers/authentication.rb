def logged_user
  User.find(session[:user_id]) if session[:user_id]
end

def require_logged_in
  redirect('/?error=ua') unless is_authenticated?
end

def is_authenticated?
  return !!session[:user_id]
end
