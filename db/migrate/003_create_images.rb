class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :photo
      t.integer :post_id
      t.integer :recipe_id
      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
