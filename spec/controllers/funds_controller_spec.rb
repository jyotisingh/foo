require "spec_helper"

describe FundsController do
  it "should list all funds" do
    Fund.destroy_all
    fund = Fund.create!({:name => "Mutual Fund", :type => "Income Retail", :nav => 100.50})
    get :index
    response.should be_success
    response.should render_template :index
    assigns(:funds).count.should == 1
    assigns(:funds)[0].name == fund.name
  end

  it "should show fund details" do
    fund = Fund.create!({:name => "Mutual Fund", :type => "Income Retail", :nav => 100.50})
    get :show, :id => fund.id
    response.should be_success
    response.should render_template :show
    assigns(:fund).should == fund
  end
end
