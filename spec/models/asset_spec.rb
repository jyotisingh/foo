require 'spec_helper'

describe Asset do
  it "should compute asset value" do
    fund = Fund.create!({:name => "a", :fund_type => "a", :nav => 100.0})
    asset = Asset.new({:fund=> fund, :quantity_purchased => 10.0})
    asset.value.should == 1000.0
  end

  it "should compute the profit on the asset" do
    fund = Fund.create!({:name => "a", :fund_type => "a", :nav => 100.0})
    asset = Asset.new({:fund=> fund, :quantity_purchased => 10.0, :book_value => 500.0})
    asset.value.should == 1000.0
    asset.profit_in_rupees.should == 500
    asset.profit_in_percentage.should == 100
  end

  it "should compute profit percentage across a period" do
    Date.stub(:today).and_return("Fri, 27 Apr 2012")
    a1,a2,a3 = [ArchivedNav.new(:date => "2012-04-21", :nav => 50.0),ArchivedNav.new(:date => "2012-04-22", :nav => 60.0), ArchivedNav.new(:date => "2012-04-23", :nav => 90.0)]
    fund = Fund.new({:name => "a", :fund_type => "a", :nav => 100.0})
    fund.archived_navs << a1
    fund.archived_navs << a2
    fund.archived_navs << a3
    fund.save!
    asset = Asset.new({:fund=> fund, :quantity_purchased => 10.0, :book_value => 500.0})
    asset.profit_statement.count.should == 4
    asset.profit_statement["2012-04-21"].should == 0.0
    asset.profit_statement["2012-04-22"].should == 20.0
    asset.profit_statement["2012-04-23"].should == 80.0
    asset.profit_statement["2012-04-27"].should == 100.0
  end
end
