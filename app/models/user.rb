class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable, :confirmable and :activatable
  ### :registerable, -- removed to add users, delete users
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :admin, :payment

  has_many :channels, :dependent => :destroy

end
