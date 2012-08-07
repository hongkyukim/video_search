require 'rubygems'
require 'openssl'
require 'base64'
#
# Library to check if a received message
# Created by Alexandre Gherschon
#
module AndBilling
  
  class Hello
    def self.say_it
      "Hello!"
    end
  end

  class Security
    def self.verify(base64_encoded_public_key , data , signature)
      key = OpenSSL::PKey::RSA.new(Base64.decode64(base64_encoded_public_key))
      key.verify( OpenSSL::Digest::SHA1.new, Base64.decode64(signature), data )
    end
  end
end


##public_key = Base64.decode64(public_key_b64)
##  signature = Base64.decode64(Base64.decode64(signature_b64))
##  signed_data = Base64.decode64(signed_data_b64)

##  key = OpenSSL::PKey::RSA.new(public_key)
##  verified = key.verify(OpenSSL::Digest::SHA1.new, signature, signed_data)

