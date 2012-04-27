require "spec_helper"

describe Investment do
  it "should compute investment value" do
    fund = Fund.create!({:name => "a", :type => "a", :nav => 100.0})
    investment = Investment.new({:fund=> fund, :quantity_purchased => 10.0})
    investment.value.should == 1000.0
  end

  it "should compute the profit on the investment" do
    fund = Fund.create!({:name => "a", :type => "a", :nav => 100.0})
    investment = Investment.new({:fund=> fund, :quantity_purchased => 10.0, :investment_amount => 500.0})
    investment.value.should == 1000.0
    investment.profit_in_rupees.should == 500
    investment.profit_in_percentage.should == 100
  end

  it "should compute profit percentage across a period" do
    archived = {"2012-04-21" => 50.0, "2012-04-22" => 60.0,"2012-04-23" => 90.0}
    fund = Fund.create!({:name => "a", :type => "a", :nav => 100.0, :archived_navs => archived})
    investment = Investment.new({:fund=> fund, :quantity_purchased => 10.0, :investment_amount => 500.0})
    investment.profit_statement.count.should == 4
    investment.profit_statement["2012-04-21"].should == 0.0
    investment.profit_statement["2012-04-22"].should == 20.0
    investment.profit_statement["2012-04-23"].should == 80.0
    investment.profit_statement["2012-04-27"].should == 100.0
  end
end
