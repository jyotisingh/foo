class CreateArchivedNav < ActiveRecord::Migration
  def up
    create_table :archived_navs do |t|
      t.date :date
      t.float :nav
      t.integer :fund_id
    end
    
  end

  def down
  end
end
