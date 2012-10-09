require 'development_mail_interceptor'

ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",
  :user_name            => "videotouch.tv",
  :password             => "videotouch123",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "localhost:3000" if Rails.env.development?
ActionMailer::Base.default_url_options[:host] = "http://www.videotouch.tv" if Rails.env.production?

Mail.register_interceptor(DevelopmentMailInterceptor) #### if Rails.env.development?
