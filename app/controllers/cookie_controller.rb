class CookieController < ApplicationController
  def new
     @languages = Language.find(:all)
     @user_languages = cookies[:user_languages] if cookies[:user_languages]
##debugger
  end

  def assign
      cookies.permanent[:user_languages] = params[:language] if params[:language]
##debugger
      redirect_to root_url
  end
end
