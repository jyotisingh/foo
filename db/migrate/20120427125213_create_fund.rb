class CreateFund < ActiveRecord::Migration
  def up
    create_table :funds do |t|
      t.string  :name
      t.string  :fund_type
      t.float   :nav
      t.date    :last_updated_date
    end
  end

  def down
    drop_table :funds
  end
end
