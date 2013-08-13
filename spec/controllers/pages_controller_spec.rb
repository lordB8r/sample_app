require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  describe "GET 'home'" do
    describe "when not signed in" do
      before(:each) do
        get :home
      end

      it "should be successful" do
        response.should be_success
      end

      #it "should have the right title" do
      #  response.should have_selector("title", :content => "#{@base_title} | Home")
      #end
    end

    describe "when signed in" do
      before(:each) do
        @user = test_sign_in(FactoryGirl.create(:user))
        other_user = FactoryGirl.create(:user, :email => "joe@shmoEmail.com")
        other_user.follow!(@user)
      end

      #it "should have the right follower/following counts" do
      #  get :home
      #  response.should have_selector("a", :href => following_user_path(@user), :content => "0 following")
      #  response.should have_selector("a", :href => followers_user_path(@user), :content => "1 follower")
      #end

    end

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
