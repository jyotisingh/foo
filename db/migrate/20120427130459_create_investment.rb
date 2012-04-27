class CreateInvestment < ActiveRecord::Migration
  def up
    create_table :investments do |t|
      t.float   :quantity_purchased
      t.float   :investment_amount
    end
  end

  def down
    drop_table :investments
  end
end
