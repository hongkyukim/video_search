class SessionsController < Devise::SessionsController
    before_filter :authenticate_user!, :except => [:new, :create ]
    ##protect_from_forgery :except => [:index, :new, :destroy]

    # you can disable csrf protection on controller-by-controller basis:
    ##skip_before_filter :verify_authenticity_token

  def new
   resource = build_resource(nil, :unsafe => true)
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource))
  end

  def create

    resource = warden.authenticate!(auth_options)

    set_flash_message(:notice, :signed_in) if is_navigational_format?

    sign_in(resource_name, resource)

    if mobile_device?
       redirect_to channels_url
    else
       respond_with resource, :location => after_sign_in_path_for(resource)
    end
  end

  # DELETE /resource/sign_out
  def destroy

    ## keep mobile device status
    keep_mobile_device = mobile_device?
    redirect_path = after_sign_out_path_for(resource_name)
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out

    if keep_mobile_device
       ## for continuing mobile mode
       session[:mobile_param] = "1"
       redirect_path += "channels"
       ##redirect_to channels_url
    end

    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.mobile
      format.any(*navigational_formats) { redirect_to redirect_path }
      format.all do
        head :no_content
      end
    end
  end

end





