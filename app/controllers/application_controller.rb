class ApplicationController < ActionController::Base

  #make these these two methods accessible to Views
  helper_method :current_user
  helper_method :logged_in?

  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def authorize
    if !logged_in?
      redirect_to root_path
    end
  end

end
