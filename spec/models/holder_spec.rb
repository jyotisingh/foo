require 'spec_helper'
describe Holder do
  it "should save a investment holder" do
    invest1 = Investment.new({:investment_amount => 1000, :quantity_purchased => 10, :fund => Fund.create!({:name=> "Fund1", :type=>"Income Retail", :nav => 10})})
    invest2 = Investment.new({:investment_amount => 2000, :quantity_purchased => 20, :fund => Fund.create!({:name=> "Fund2", :type=>"Growth Retail", :nav => 11})})
  
    holder = Holder.new(:name => "Manju", :investments => [invest1, invest2])
    holder.save!
    holder.name.should == "Manju"
    holder.investments.count.should == 2
    holder.investments.should include(invest1, invest2)
  end

  describe :validations do
    it "should validate presence of name" do
      holder = Holder.new
      holder.valid?.should == false
      holder.errors[:name].should include("can't be blank")
    end

    it "should validate presence of mandatory fields in investment" do
      holder = Holder.new({:investments => [Investment.new]})
      holder.valid?.should == false
      holder.errors[:investments].should include("is invalid")
    end
  end

  it "should get current assets value" do
    invest1 = Investment.new({:investment_amount => 1000, :quantity_purchased => 10, :fund => Fund.create!({:name=> "Fund1", :type=>"Income Retail", :nav => 10})})
    invest2 = Investment.new({:investment_amount => 2000, :quantity_purchased => 20, :fund => Fund.create!({:name=> "Fund2", :type=>"Growth Retail", :nav => 11})})
  
    holder = Holder.create(:name => "Manju", :investments => [invest1, invest2])
    holder.assets_value.should ==  320
  end
end
