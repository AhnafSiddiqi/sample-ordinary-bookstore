module SessionsHelper
  def log_in(user)
    session[:login] = user.login_id
  end

  def current_user
    retrieve_user = User.find_by(login_id: session[:login]) # need to change to db query
    @current_user ||= retrieve_user
  end

  def logged_in? 
    !current_user.nil?
  end

  def log_out
    session.delete(:login)
    @current_user = nil
  end
end