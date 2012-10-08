class User < ActiveRecord::Base
  has_many :authentications, :dependent => :destroy
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable, :confirmable and :activatable
  ### :registerable, -- removed to add users, delete users
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :admin, :payment

  has_many :channels, :dependent => :destroy


  def apply_omniauth(omniauth)
debugger
     ### when we use OpenID
     self.email = omniauth['user_info']['email'] if email.blank? && omniauth['user_info']


     authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  ### disable password validation
  def password_required?
      (authentications.empty? || !password.blank?) && super
  end


end
