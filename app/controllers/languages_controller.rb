class LanguagesController < InheritedResources::Base
  ## authentication
  before_filter :authenticate_user!, :except => [:show, :index]
  ## authorization
  load_and_authorize_resource


end
