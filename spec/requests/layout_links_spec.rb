require 'spec_helper'

describe "LayoutLinks" do
  describe "GET layout_links" do
    it "should have a Home page at '/'" do
      get '/'
      response.should be_success
    end

    it "should have a Contact page at '/contact'" do
      get '/contact'
      response.should be_success
    end

    it "should have a About page at '/about'" do
      get '/about'
      response.should be_success
    end

    it "should have a Help page at '/help'" do
      get '/help'
      response.should be_success
    end

    it "should have a Signup page at '/signup'" do
      get '/signup'
      response.should be_success
    end

  end

  #describe "when not signed in" do
  #  it "should have a signin link" do
  #    visit root_path
  #    response.should have_selector("a", :href => signin_path, :content => "Sign in")
  #  end
  #end
  ##skipped tests on pg 358 (9.4.3) b/c visit root_path fails (visit isn't liked w/o webrat or capybara)
end
