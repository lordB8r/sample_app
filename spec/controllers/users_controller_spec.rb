require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'show'" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end
  end

  # Tests here would be used w/ have_selector, but that is broken right now (capybara and webrat won't work on this
  #it "should have the right title" do
  #  get :show, :id =>@user
  #  response.should have_selector("title", :content=>@user.name)
  #end

  #it "should include the user's name" do
  #  get :show, :id =>@user
  #  response.should have_selector("h1", :content=>@user.name)
  #end

  #it "should have a profile image" do
  #  get :show, :id =>@user
  #  response.should have_selector("h1>img", :class=>"gravatar")
  #end


  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

end
