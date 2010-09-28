require 'spec_helper'

describe UsersController do
  include RSpec::Rails::ControllerExampleGroup
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "'new' page" do
    it "should contain 'Sign up'" do
      get 'new'
      response.should have_selector('title', :content => 'Sign up')
    end


    it "should be routed to '/signup'" do
      get '/signup'
      response.should have_selector('title', :content => 'Sign up')
    end
  end
end
