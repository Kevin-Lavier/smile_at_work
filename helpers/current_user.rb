# Returns the currently logged-in user based on the session data.
# If the user no longer exists, it clears the session.
def current_user
  if session[:user_id]
    @current_user ||= User.find_by(id: session[:user_id])
    session[:user_id] = nil unless @current_user  # Clear session if user is not found
  end
end
