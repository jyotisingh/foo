class CreateAsset < ActiveRecord::Migration
  def up
    create_table :assets do |t|
      t.float   :quantity_purchased
      t.float   :book_value
      t.date   :purchase_date
      t.integer :user_id
      t.integer :fund_id
    end
  end

  def down
    drop_table :assets
  end
end
