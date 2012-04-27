class Investment < ActiveRecord::Base
  key :quantity_purchased, Float, :required => true
  key :investment_amount, Float, :required => true
  belongs_to :fund, :required => true

  def value
    fund.nav * quantity_purchased
  end

  def profit_in_rupees
    value - investment_amount
  end

  def profit_in_percentage
    (profit_in_rupees / investment_amount) * 100.0
  end

  def profit_statement
    statement ={}
    fund.archived_navs.each do |date, nav|
      value_on_date = quantity_purchased * nav
      profit_in_rupees_on_date = value_on_date - investment_amount
      profit_in_percentage_on_date = (profit_in_rupees_on_date / investment_amount) * 100
      statement[date] = profit_in_percentage_on_date
    end
    statement[fund.last_updated_date.to_s] = profit_in_percentage
    statement
  end
end
