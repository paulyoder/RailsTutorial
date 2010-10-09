require 'spec_helper'

describe PagesController do
  include RSpec::Rails::ControllerExampleGroup
  render_views

  describe "GET 'home'" do
    it "should be successful" do
      get :home
      response.should be_success
    end

    it "should have the right title" do
      get :home
      response.should have_selector("title", :content => "Home")
    end

    describe "when not signed in" do

      before :each do
        get :home
      end

      it "should have a 'sign in' link" do
        response.should have_selector("a", :href => signin_path,
                                           :content => "Sign in")
      end
    end

    describe "when signed in" do

      before :each do
        @user = test_sign_in(Factory(:user))
        other_user = Factory(:user)
        other_user.follow!(@user)
      end

      it "should have a 'sign out' link" do
        get :home
        response.should have_selector("a", :href => signout_path,
                                           :content => "Sign out")
      end

      it "should have a link to the user profile" do
        get :home
        response.should have_selector("a", :content => "Profile")
      end


      it "should have the right follower/following counts" do
        get :home
        response.should have_selector("a", :href => following_user_path(@user),
                                           :content => "0 following")
        response.should have_selector("a", :href => followers_user_path(@user),
                                           :content => "1 follower")

      end
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title" do
      get 'contact'
      response.should have_selector("title", :content => "Contact")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
      get 'about'
      response.should have_selector("title", :content => "About")
    end
  end

end
