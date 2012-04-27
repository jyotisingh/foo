class Investment < ActiveModel
  key :quantity_purchased, Float
  key :investment_amount, Float
  belongs_to :fund
end
