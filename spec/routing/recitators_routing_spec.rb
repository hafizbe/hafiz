require "spec_helper"

describe RecitatorsController do
  describe "routing" do

    it "routes to #index" do
      get("/recitators").should route_to("recitators#index")
    end

    it "routes to #new" do
      get("/recitators/new").should route_to("recitators#new")
    end

    it "routes to #show" do
      get("/recitators/1").should route_to("recitators#show", :id => "1")
    end

    it "routes to #edit" do
      get("/recitators/1/edit").should route_to("recitators#edit", :id => "1")
    end

    it "routes to #create" do
      post("/recitators").should route_to("recitators#create")
    end

    it "routes to #update" do
      put("/recitators/1").should route_to("recitators#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/recitators/1").should route_to("recitators#destroy", :id => "1")
    end

  end
end
