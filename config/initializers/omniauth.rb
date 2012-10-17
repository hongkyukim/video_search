require 'omniauth-openid'
require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  ###provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  provider :twitter, 'YoNWklBzW9Au3OG7AlG1w', 'UaU15OPzBtBGVpv03HDcHlFcTXbO9EPLweWro2fMgY' if Rails.env.development?
  provider :twitter, 'YoNWklBzW9Au3OG7AlG1w', 'UaU15OPzBtBGVpv03HDcHlFcTXbO9EPLweWro2fMgY' if Rails.env.production?

  ###provider :facebook, 'APP_ID', 'APP_SECRET'
  provider :facebook, '447068042001239', '57ef12026f217b7adb96d3dc58f451e1',
               :scope => 'email', :display => 'popup' if Rails.env.development?

  provider :facebook, '484584161559849', '601f43f68d06d46aaa37bfb2f4b95e62',
               :scope => 'email', :display => 'popup' if Rails.env.production?
  ###provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'

  ###provider :open_id, OpenID::Store::Filesystem.new('/tmp')
  ###provider :open_id, :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  ###provider :open_id, :name => 'yahoo',  :identifier => 'yahoo.com'

end


