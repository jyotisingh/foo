require "spec_helper"

describe UsersController do
  it "should display user registration page" do
    get :new
    response.should be_success
    response.should render_template :new
    assigns(:user).should_not be_nil
  end

  it "should create a new user" do
    initial_count = User.count
    post :create, :user => {:name => "foo", :email => "a@a.com"}
    response.should be_success
    response.should render_template :create
    User.count.should == initial_count +1
  end
  
  it "should render new when there are validation errors" do
    post :create, :user => {:name => "foo"}
    response.should render_template :new
    assigns(:user).errors[:email].should include "can't be blank"
  end

end
