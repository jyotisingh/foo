require 'spec_helper'
describe User do
  it "should save a user" do
    user = User.new(:name => "Manju", :email => "a@b.com")
    user.save
    user.reload
    user.name.should == 'Manju'
    user.email.should == "a@b.com"
  end

  it "should save a user with assets" do
    asset1 = Asset.new({:purchase_date => Date.new(2000,1,1), :book_value => 1000, :quantity_purchased => 10, :fund => Fund.create!({:name=> "Fund1", :fund_type=>"Income Retail", :nav => 10})})
    asset2 = Asset.new({:purchase_date => Date.new(2000,1,1), :book_value => 2000, :quantity_purchased => 20, :fund => Fund.create!({:name=> "Fund2", :fund_type=>"Growth Retail", :nav => 11})})
    user = User.new(:name => "Manju", :email => "a@b.com")
    user.assets << asset1
    user.assets << asset2
    user.save!
    user.name.should == "Manju"
    user.assets.count.should == 2
    user.assets.should include(asset1, asset2)
  end

  describe :validations do
    it "should validate presence of name" do
      user = User.new
      user.valid?.should == false
      user.errors[:name].should include("can't be blank")
      user.errors[:email].should include("can't be blank")
    end

    it "should validate presence of mandatory fields in asset" do
      user = User.new
      user.assets << Asset.new
      user.valid?.should == false
      user.errors[:assets].should include("is invalid")
    end
  end

  it "should get current assets value" do
    asset1 = Asset.new({:purchase_date => Date.new(2000,1,1), :book_value => 1000, :quantity_purchased => 10, :fund => Fund.create!({:name=> "Fund1", :fund_type=>"Income Retail", :nav => 10})})
    asset2 = Asset.new({:purchase_date => Date.new(2000,1,1), :book_value => 2000, :quantity_purchased => 20, :fund => Fund.create!({:name=> "Fund2", :fund_type=>"Growth Retail", :nav => 11})})
  
    user = User.create(:name => "Manju")
    user.assets << asset1
    user.assets << asset2
    user.assets_value.should ==  320
  end
end
