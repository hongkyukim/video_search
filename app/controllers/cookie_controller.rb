class CookieController < ApplicationController
  def new
     @languages = Language.find(:all)
     if cookies[:user_languages]
        @user_languages = cookies[:user_languages]
        if cookies[:user_languages] ==""
            @user_languages = "en"
        end
     else
        @user_languages = "en"
     end
     @current_language = Language.find_by_shortname(@user_languages);
##debugger
  end

  def assign
      cookies.permanent[:user_languages] = params[:language] if params[:language]
##debugger
      redirect_to root_url
  end
end
