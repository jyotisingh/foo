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
    response.should redirect_to user_assets_path(assigns(:user))
    assigns(:user).should_not be_nil
    User.count.should == initial_count +1
    flash[:notice].should == "Registration Successful!"
  end
  
  it "should render new when there are validation errors" do
    post :create, :user => {:name => "foo"}
    response.should render_template :new
    assigns(:user).errors[:email].should include "can't be blank"
  end
  
  it "should edit user" do
    user = User.create!(:name => "a", :email => "a@@.com")
    get :edit, :id => user.id
    assigns(:user).should == user
    response.should be_success
    response.should render_template :edit
  end

  it "should update user" do
    user = User.create!(:name => "a", :email => "a@@.com")
    put :update, :id => user.id, :user => {:name => "foo", :email => "1@q.com"}
    response.should redirect_to user_assets_path(assigns(:user))
    flash[:notice].should== "Successfully updated profile!"
    user.reload.name.should == "foo"
    user.email.should == "1@q.com"
  end
end
