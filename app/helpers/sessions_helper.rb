module SessionsHelper
  
  def log_in(user)
    session[:user_id] = user.id #Coockie on the browser "Temporary"
  end
  
  # Returns the current user that is logged in
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
    # Ruby line that verifies if the current user exists or not
  end
  
  # Returns true if logged in, else false
  def logged_in?
    !current_user.nil?
  end
  
  # Logs out
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
