class AddtimesToRecipes < ActiveRecord::Migration
  def self.up
    change_table :recipes do |t|
      t.string :prep_time
    t.string :cooking_time
    end
  end

  def self.down
    change_table :recipes do |t|
      t.remove :prep_time
    t.remove :cooking_time
    end
  end
end
