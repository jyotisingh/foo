require 'spec_helper'

describe Fund do
  it "should save fund" do
    fund = Fund.create!({:name => "Fund 1", :type => "Income Retail", :nav => 2000})
    fund.name.should == "Fund 1"
    fund.type.should == "Income Retail"
    fund.nav.should == 2000.0
  end

  it "should validate mandatory fields" do
    fund = Fund.new
    fund.valid?.should == false
    fund.errors[:name].should include "can't be blank"
    fund.errors[:type].should include "can't be blank"
    fund.errors[:nav].should include "can't be blank"
  end

  it "should archive old navs" do
    Date.stub(:today).and_return("Fri, 27 Apr 2012")
    fund = Fund.create!({:name => "F1", :type => "Income Retail", :nav => 100.5})
    fund.last_updated_date.to_s.should == "2012-04-27"
    Date.stub(:today).and_return("Sat, 28 Apr 2012")
    fund.update_attributes!({:nav => 150})
    fund.reload
    fund.nav.should == 150.0
    fund.last_updated_date.to_s.should == "2012-04-28"
    fund.archived_navs.count.should == 1
    fund.archived_navs["2012-04-27"].should == 100.5
  end
end
