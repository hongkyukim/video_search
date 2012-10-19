require 'spec_helper'

describe CookieController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'assign'" do
    it "returns http success" do
      get 'assign'
      response.should be_success
    end
  end

end
