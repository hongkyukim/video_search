class DevelopmentMailInterceptor
  def self.delivering_email(message)
##debugger
    message.subject = "[#{message.to}] #{message.subject}"
    message.to = "videotouchapp@gmail.com"
    ### this address will receive intercepted messages  
    ### message.to = "hongkyukim@yahoo.com"
##debugger
  end
end


