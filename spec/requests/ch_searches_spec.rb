require 'spec_helper'

describe "ChSearches" do
  describe "GET /ch_searches" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get ch_searches_path
      response.status.should be(200)
    end
  end
end
