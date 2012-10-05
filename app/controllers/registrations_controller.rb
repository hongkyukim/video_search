class RegistrationsController < Devise::RegistrationsController
  def create
    super
    session[:omniauth] = nil unless @user.new_record? 

  
    ##if registration_enabled?
    ##  super
      ###session[:omniauth] = nil unless @user.new_record?
    ##else
    ##  flash[:alert] = I18n.t("registration_disabled")
    ##  redirect_to action: :new
    ##end
  

  end


  private
  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end

end
