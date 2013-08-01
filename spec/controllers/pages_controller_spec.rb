require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    @base_title = "Ruby on Rails Tutorial Sample App | "
  end

  describe "GET 'home'" do
    it "responds with 200" do
      get 'home'
      response.should be_success
    end
    #it "should have the right title" do
    #  get 'home'
    #  response.should has_css("title", :content=> @base_title + "Home")
    #end
  end

  describe "GET 'contact'" do
    it "responds with 200" do
      get 'contact'
      response.should be_success
    end
  end

  describe "Get 'about'" do
    it "responds with 200" do
      get 'about'
      response.should be_success
    end
  end

end
