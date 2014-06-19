class CreateVieweds < ActiveRecord::Migration
  def self.up
    create_table :vieweds do |t|
      t.integer :recipe_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :vieweds
  end
end
