class SessionsController < Devise::SessionsController
    before_filter :authenticate_user!
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
       redirect_to root_url
    else
       respond_with resource, :location => after_sign_in_path_for(resource)
    end
  end


end





