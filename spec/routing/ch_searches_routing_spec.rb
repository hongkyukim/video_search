require "spec_helper"

describe ChSearchesController do
  describe "routing" do

    it "routes to #index" do
      get("/ch_searches").should route_to("ch_searches#index")
    end

    it "routes to #new" do
      get("/ch_searches/new").should route_to("ch_searches#new")
    end

    it "routes to #show" do
      get("/ch_searches/1").should route_to("ch_searches#show", :id => "1")
    end

    it "routes to #edit" do
      get("/ch_searches/1/edit").should route_to("ch_searches#edit", :id => "1")
    end

    it "routes to #create" do
      post("/ch_searches").should route_to("ch_searches#create")
    end

    it "routes to #update" do
      put("/ch_searches/1").should route_to("ch_searches#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/ch_searches/1").should route_to("ch_searches#destroy", :id => "1")
    end

  end
end
