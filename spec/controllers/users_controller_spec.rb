require 'spec_helper'

describe UsersController do
  render_views

  describe "Get 'index'" do
    describe "for non-signed-in users" do
      it "should deny access" do
        get :index
        response.should redirect_to(signin_path)
        flash[:notice].should =~ /sign in/i
      end
    end

    describe "for signed-in users" do
      before(:each) do
        @user = test_sign_in(FactoryGirl.create(:user))
        second = FactoryGirl.create(:user, :email => "another@example.com")
        third = FactoryGirl.create(:user, :email => "another@example.net")
        @users = [@user, second, third]
        30.times do
          @users << FactoryGirl.create(:user)
        end
      end

      it "should be successful" do
        get :index
        response.should be_success
      end

      #it "should have the right title" do
      #  get :index
      #  response.should have_selector("title", :content => "All users")
      #end

      #it "should have an element for each user" do
      #  get :index
      #  @users.each do |user|
      #    response.should have_selector("li", :content => user.name)
      #  end
      #end

    end
  end


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

    #it "should show the user's microposts" do
    #  mp1 = FactoryGirl.create(:micropost, :user => @user, :content => "foobar was here")
    #  mp2 = FactoryGirl.create(:micropost, :user => @user, :content => "foobar ate a monkey")
    #  get :show, :id => @user
    #  response.should have_selector("span.content", :content => mp1.content)
    #  response.should have_selector("span.content", :content => mp2.content)
    #end
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

    #it "should have the right title" do  # still doesn't work because rails doesn't work w/ capybara
    #  get :new
    #  response.should have_selector("title", :content => "sign up")
    #end
    it "uses HTTPS when creating a user" do
      request.env['HTTPS'] = 'on'
      get :new
      response.should render_template :new
    end
  end

  describe "POST 'create'" do
    describe "failure" do
      before (:each) do
        @attr = {:name => "", :email=> "", :password => "", :password_confirmation => ""}
      end

      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end

      #it "should have the right title" do
      #  post :create, :user => @attr
      #  response.should have_select("title", :content => "Sign up")
      #end

      it "should render the 'new page'" do
        post :create, :user => @attr
        response.should render_template('new')
      end
    end
    describe "success" do
      before (:each) do
        @attr = {:name => "New User", :email=> "user@example.com", :password => "foobar", :password_confirmation => "foobar"}
      end

      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it "should sign the user in" do
        post :create, :user => @attr
        controller.should be_signed_in
      end

      it "should redirect to the user show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end

      it "should have a welcome message" do
        post :create, :user => @attr
        flash[:success].should =~ /welcome to the sample app/i
      end
    end

  end

  describe "GET 'edit'" do
    before(:each)do
      @user = FactoryGirl.create(:user)
      test_sign_in(@user)
    end

    it "should be successful" do
      get :edit, :id => @user
      response.should be_success
    end

    #it "should have the right title" do
    #  get :edit, :id => @user
    #  response.should have_selector("title", :content => "Edit user")
    #end

    #it "should have a link to change the Gravatar" do
    #  get :edit, :id => @user
    #  gravatar_url = "http://gravatar.com/emails"
    #  response.should have_selector("a", :href => gravatar_url,
    #                                     :content => "change")
    #end
  end

  describe "PUT 'edit'" do
    before(:each)do
      @user = FactoryGirl.create(:user)
      test_sign_in(@user)
    end

    describe "failure" do
      before(:each) do
        @attr = {:email => "", :name => "", :password => "", :password_confirmation => ""}
      end

      it "should render the 'edit' page" do
        put :update, :id => @user, :user => @attr
        response.should render_template('edit')
      end

      #it "should have the right title" do
      #  put :update, :id => @user, :user=>@attr
      #  response.should have_selector("title", :content => "Edit user")
      #end
    end

    describe "success" do
      before (:each) do
        @attr = {:name => "New Name", :email => "user@example.org", :password => "barbaz", :password_confirmation => "barbaz"}
      end

      it "should change the user's attributes" do
        put :update, :id => @user, :user => @attr
        @user.reload
        @user.name.should == @attr[:name]
        @user.email.should == @attr[:email]
      end

      it "should redirect to the user show page" do
        put :update, :id=>@user, :user=>@attr
        response.should redirect_to(user_path(@user))
      end

      it "should have a flash message" do
        put :update, :id => @user, :user=>@attr
        flash[:success].should =~ /updated/
      end
    end
  end

  describe "authentication of edit/update pages" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    describe "for non-signed-in users" do
      it "should deny access to 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(signin_path)
      end

      it "should deny access to 'update'" do
        get :update, :id => @user
        response.should redirect_to(signin_path)
      end
    end

    describe "for signed-in users" do
      before (:each) do
        wrong_user = FactoryGirl.create(:user, :email => "user@example.net")
        test_sign_in(wrong_user)
      end

      it "should require matching users for 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(root_path)
      end

      it "should require matching users for 'update'" do
        get :update, :id => @user
        response.should redirect_to(root_path)
      end
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    describe "as a non-signed-in-user" do
      it "should deny access" do
        if !@user.admin.nil?
          delete :destroy, :id =>@user
          response.should redirect_to(root_path)
        end

      end
    end

    describe "as an admin user" do
      before(:each) do
        admin = FactoryGirl.create(:user, :email=>"admin@example.com", :admin => true)
        test_sign_in(admin)
      end

      it "should destroy the user" do
        lambda do
          delete :destroy, :id => @user
        end.should change(User, :count).by(-1)
      end

      it "should redirect to the users page" do
        delete :destroy, :id => @user
        response.should redirect_to(users_path)
      end
    end

  end

  describe "follow pages" do
    describe "when not signed in" do
      it "should protect the 'following'" do
        get :following, :id => 1
        response.should redirect_to(signin_path)
      end

      it "should protect 'followers'" do
        get :followers, :id => 1
        response.should redirect_to(signin_path)
      end
    end

    describe "when signed in" do
      before(:each) do
        @user = test_sign_in(FactoryGirl.create(:user))
        @other_user = FactoryGirl.create(:user, :email => "joe@shmoo.net")
        @user.follow!(@other_user)
      end

      #it "should show user following" do
      #  get :following, :id => @user
      #  response.should have_selector("a", :href => user_path(@other_user, :content => @other_user.name))
      #end
      #
      #it "should show user followers" do
      #  get :followers, :id => @other_user
      #  response.should have_selector("a", :href => user_path(@user), :content => @user.name)
      #end
    end
  end
end
