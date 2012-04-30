require "spec_helper"

describe AssetsController do
  it "should add a new asset for a user" do
    user = User.create!(:name => "a", :email => "a@aa.com")
    get :new, :user_id => user.id
    assigns(:user).should == user
    assigns(:asset).should_not be_nil
  end

  it "should create an asset for a user" do
    user = User.create!(:name => "a", :email => "a@aa.com")
    post :create, :user_id => user.id, :asset => {:quantity_purchased => 10, :book_value => 10.0}
    response.should redirect_to user_assets_path 
    user.reload
    user.assets.count.should ==1
    user.assets[0].quantity_purchased == 10
    user.assets[0].book_value == 10.0
  end

  it "should list user assets" do
    user = User.new(:name => "a", :email => "a@aa.com")
    user.assets << Asset.new(:quantity_purchased => 10, :book_value => 10.0)
    user.save
    get :index, :user_id => user.id
    assigns(:user).should == user
    assigns(:assets).should == user.assets
  end
end
