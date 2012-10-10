class UserMailer < ActionMailer::Base
  default :from => "videotouch.tv@gmail.com"

  def registration_confirmation(user)
    @user = user
debugger
    ###attachments["rails.png"] = File.read("#{Rails.root}/public/images/rails.png")
    mail(:to => user.email, :subject => "Registered")
  end
end
