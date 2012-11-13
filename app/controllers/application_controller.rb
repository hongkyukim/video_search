class ApplicationController < ActionController::Base
  has_mobile_fu

  helper :all
  protect_from_forgery
  before_filter :prepare_for_mobile, :set_user_language, :set_locale
  
  ##helper_method :current_user
  helper_method :yt_client
  helper_method :get_languages


  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end

  def yt_client
    @yt_client ||= YouTubeIt::Client.new(:username => YouTubeITConfig.username ,
               :password =>  YouTubeITConfig.password , :dev_key => YouTubeITConfig.dev_key)
  end

  ### get default language
  def get_cur_language
    if cookies[:user_languages]
       userlanguage = cookies[:user_languages] 
    else
       userlanguage = "en"
    end
    current_language = Language.find_by_shortname(userlanguage);

    if current_language
       cur_language_name = current_language.name
       cur_language_shortname = current_language.shortname
    else
       cur_language_name = 'English'
       cur_language_shortname = 'en'
    end
    [cur_language_name, cur_language_shortname]
  end

private

  ##def current_user
  ##      @current_user ||= User.find_by_id(session[:user_id])
  ##end

  ##def current_user
  ##      @current_user ||= User.find_by_remember_token(cookies[:remember_token]) if cookies[:remember_token]
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
  def logged_in?
       !!current_user
  end

  def get_languages
    @languages = Language.find
  end

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

  def set_user_language
     I18n.locale = 'en'  ## wk en kr

     I18n.locale = current_user.language if logged_in?
  end
  def get_user_language
     I18n.locale
  end
  def set_locale
     I18n.locale = params[:locale] if params[:locale].present?
  end

end
