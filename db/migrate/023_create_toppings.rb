class CreateToppings < ActiveRecord::Migration
  def self.up
    create_table :toppings do |t|
      t.string :title
      t.string :ingredients
      t.string :description
      t.integer :recipe_id
      t.timestamps
    end
  end

  def self.down
    drop_table :toppings
  end
end
