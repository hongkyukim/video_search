class CookieController < ApplicationController
  def new
     @languages = Language.find(:all)
     @user_languages = cookies[:user_languages] if cookies[:user_languages]
  end

  def assign
      cookies.permanent[:user_languages] = params[:language] if params[:language]
      redirect_to root_url
  end
end
