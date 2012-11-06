class Language < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 256 }
end
