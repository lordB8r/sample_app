require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    it "responds with 200" do
      get 'home'
      response.should be_success
    end
    it "should have the right title" do
      get 'home'
      response.should have_selector("title", :content=> "Ruby on Rails Tutorial Sample App | Home")
    end
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
