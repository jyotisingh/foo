class Asset < ActiveRecord::Base
  attr_accessible :quantity_purchased, :book_value, :purchase_date, :fund, :fund_id, :user, :user_id
  belongs_to :fund
  belongs_to :user
  validates :quantity_purchased, :book_value, :purchase_date, :presence => true
  
  def value
    fund.nav * quantity_purchased
  end

  def profit_in_rupees
    value - book_value
  end

  def profit_in_percentage
    (profit_in_rupees / book_value) * 100.0
  end

  def profit_statement
    statement ={}
    fund.archived_navs.each do |archive|
      value_on_date = quantity_purchased * archive.nav
      profit_in_rupees_on_date = value_on_date - book_value
      profit_in_percentage_on_date = (profit_in_rupees_on_date / book_value) * 100
      statement[archive.date.to_s] = profit_in_percentage_on_date
    end
    statement[fund.last_updated_date.to_s] = profit_in_percentage
    statement
  end
end
