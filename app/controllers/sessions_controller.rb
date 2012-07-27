class SessionsController < Devise::SessionsController
    ##before_filter :authenticate_user!
##protect_from_forgery :except => [:index, :new, :destroy]

    # you can disable csrf protection on controller-by-controller basis:
    skip_before_filter :verify_authenticity_token

  def new
 debugger
   resource = build_resource(nil, :unsafe => true)
debugger
    clean_up_passwords(resource)
debugger
    respond_with(resource, serialize_options(resource))
debugger
  end


  def create
debugger
    resource = warden.authenticate!(auth_options)
debugger
    set_flash_message(:notice, :signed_in) if is_navigational_format?
debugger
    sign_in(resource_name, resource)
debugger
    if mobile_device?
debugger
       respond_with resource, :location => after_sign_in_path_for(resource)
       redirect_to root_url
    else
       respond_with resource, :location => after_sign_in_path_for(resource)
    end
  end


end





