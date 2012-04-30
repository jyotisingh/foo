require 'spec_helper'

describe Admin::FundsController do
  it "should add new fund" do
    get :new
    response.should be_success
    response.should render_template :new
    assigns(:fund).should_not be_nil
  end

  it "should create a new fund" do
    initial_count = Fund.count
    post :create , :fund => {:nav => 10, :name => "foo", :fund_type => "foo"}
    assigns(:fund).should_not be_nil
    Fund.count.should == initial_count + 1
    response.should redirect_to admin_funds_path 
    flash[:notice].should == "Fund created!"
  end

  it "should render new when save fails" do
    post :create , :fund => {:nav => 1, :name => ""}
    response.should render_template :new
    assigns(:fund).nav.should_not be_nil
  end

  it "should list all funds" do
    fund = Fund.create!(:name => "a", :fund_type=> "a", :nav => 100)
    get :index
    response.should be_success
    response.should render_template :index
    assigns(:funds).should include(fund)
  end
end
