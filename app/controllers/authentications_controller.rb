class AuthenticationsController < InheritedResources::Base

  def index
     @authentications = current_user.authentications if current_user
  end

  def create
     omniauth = request.env["omniauth.auth"]

     authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
     if authentication
        flash[:notice] = "Signed in successfully with auth."

        ### to authentication's user
        sign_in_and_redirect(:user, authentication.user)
     elsif current_user
        ### to current user
        current_user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
        flash[:notice] = "Authentication successful with current user."

        redirect_to authentications_url
     else
        user = User.new
        ###user.authentications.build(:provider => omniauth ['provider'], :uid => omniauth['uid'])

        user.apply_omniauth(omniauth)

	if user.save
	  flash[:notice] = "Signed up and Signed in successfully."
	  sign_in_and_redirect(:user, user)
	else
          ### dont need extra key
	  session[:omniauth] = omniauth.except('extra')

          if user.email
             new_user = User.find_by_email(user.email)
             if new_user
                 new_user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
                 flash[:notice] = "Authentication successful with existing user."

                 redirect_to authentications_url
             else
	         redirect_to new_user_registration_url
             end 
          else
	     redirect_to new_user_registration_url
          end
	end

        ###user.save(:validate => false)
        ###flash[:notice] = "Signed in successfully."
        ###sign_in_and_redirect(:user, user)
      end
  end


  def create4567
     omniauth = request.env["omniauth.auth"]
     authentication = Authentication.find_by_provder_and_uid(omniauth['provider'], omniauth['uid'])
     if authentication
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, authentication.user)
     else
        current_user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
        flash[:notice] = "Authentication successful."
        redirect_to authentications_url
     end
  end


  def create12345
    ####render :text => request.env["omniauth.auth"].to_yaml
    auth = request.env["omniauth.auth"]
    current_user.authentications.find_or_create_by_provider_and_uid(auth['provider'], auth['uid'])
    flash[:notice] = "Authentication successful."
    redirect_to authentications_url


    ###auth = request.env["omniauth.auth"] current_user.authentications.create(:provider => auth['provider'], :uid => auth['uid'])
    ###flash[:notice] = "Authentication successful."
    ###redirect_to authentications_url
  end
  
  def destroy
     @authentication = current_user.authentications.find(params[:id])

     @authentication.destroy
     flash[:notice] = "Successfully destroyed authentication."
     redirect_to authentications_url
  end



end
