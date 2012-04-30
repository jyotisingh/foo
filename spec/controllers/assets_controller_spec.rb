require "spec_helper"

describe AssetsController do
  it "should add a new asset for a user" do
    user = User.create!(:name => "a", :email => "a@aa.com")
    get :new, :user_id => user.id
    response.should be_success
    response.should render_template :new
    assigns(:user).should == user
    assigns(:asset).should_not be_nil
  end

  it "should create an asset for a user" do
    user = User.create!(:name => "a", :email => "a@aa.com")
    post :create, :user_id => user.id, :asset => {:purchase_date => Date.new(2000,1,1),:quantity_purchased => 10, :book_value => 10.0}
    response.should redirect_to user_assets_path 
    user.reload
    user.assets.count.should ==1
    user.assets[0].quantity_purchased == 10
    user.assets[0].book_value == 10.0
    flash[:notice].should == "Successfully added!"
  end

  it "should list user assets" do
    user = User.new(:name => "a", :email => "a@aa.com")
    user.assets << Asset.new(:quantity_purchased => 10, :book_value => 10.0, :purchase_date => Date.new(2000,1,1))
    user.save!
    get :index, :user_id => user.id
    assigns(:user).should == user
    assigns(:assets).should == user.assets
  end

  it "should edit assets for user" do
    user = User.new(:name => "a", :email => "a@aa.com")
    user.assets << Asset.new(:quantity_purchased => 10, :book_value => 10.0, :purchase_date => Date.new(2000,1,1))
    user.save!
    get :edit, :user_id => user.id, :id => user.assets.first.id
    assigns(:user).should == user
    assigns(:asset).should == user.assets.first
    response.should be_success
    response.should render_template :edit
  end

  it "should update asset" do
    user = User.new(:name => "a", :email => "a@aa.com")
    user.assets << Asset.new(:quantity_purchased => 10, :book_value => 10.0, :purchase_date => Date.new(2000,1,1))
    user.save!
    put :update, :user_id => user.id, :id => user.assets[0].id, :asset => {:quantity_purchased => 100, :book_value => 10.0, :purchase_date => "Fri, 27 Apr 2012"}
    response.should redirect_to user_assets_path(user) 
    user.reload
    user.assets.first.quantity_purchased.should == 100
    flash[:notice].should == "Successfully updated!"
  end

  it "should destroy assets" do
    user = User.new(:name => "a", :email => "a@aa.com")
    user.assets << Asset.new(:quantity_purchased => 10, :book_value => 10.0, :purchase_date => Date.new(2000,1,1))
    user.save!
    delete :destroy, :user_id => user.id, :id => user.assets[0].id
    response.should redirect_to user_assets_path(user) 
    user.reload
    user.assets.should be_empty
    flash[:notice].should == "Successfully deleted!"
  end
end
