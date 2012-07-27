class ApplicationController < ActionController::Base
  has_mobile_fu

  helper :all
  protect_from_forgery
  before_filter :prepare_for_mobile
  ##helper_method :current_user
  helper_method :yt_client
  helper_method :get_languages


  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end

  def yt_client
    @yt_client ||= YouTubeIt::Client.new(:username => YouTubeITConfig.username , :password => YouTubeITConfig.password , :dev_key => YouTubeITConfig.dev_key)
  end

  private

  ##def current_user
  ##      @current_user ||= User.find_by_id(session[:user_id])
  ##end

  ##def signed_in?
  ##     !!current_user
  ##end

  ## not needed for device 07242012
  ##def current_user_session
  ##  return @current_user_session if defined?(@current_user_session)
  ##  @current_user_session = UserSession.find
  ##end
  
  ##def current_user
  ##  return @current_user if defined?(@current_user)
  ##  @current_user = current_user_session && current_user_session.record
  ##end


  def get_languages
    @languages = Language.find
  end

private

def mobile_device?
  ###debugger
  if session[:mobile_param]
    session[:mobile_param] == "1"
  else
    request.user_agent =~ /Mobile|webOS|Android|Blackberry/
  end
end
helper_method :mobile_device?

def prepare_for_mobile
  ###debugger
  session[:mobile_param] = "1" if params[:format] == "mobile"
  session[:mobile_param] = params[:mobile] if params[:mobile]
  request.format = :mobile if mobile_device?
end 
  
  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource)
    root_path
  end
  # Overwriting the sign_out redirect path method
  def after_sign_up_path_for(resource)
    root_path
  end
end
