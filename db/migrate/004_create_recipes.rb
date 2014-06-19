class CreateRecipes < ActiveRecord::Migration
  def self.up
    create_table :recipes do |t|
      t.string :content
      t.string :main_ingredient
      t.string :course
      t.integer :post_id
      t.integer :image_id
      t.timestamps
    end
  end

  def self.down
    drop_table :recipes
  end
end
