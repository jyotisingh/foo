class CreateHolder < ActiveRecord::Migration
  def up
    create_table :holders do |t|
      t.string  :name
    end
  end

  def down
    drop_table :holders
  end
end
