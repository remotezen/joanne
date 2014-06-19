class AddColumnImageToRecipes < ActiveRecord::Migration
  def self.up
    change_table :recipes do |t|
      t.string :image
    end
  end

  def self.down
    change_table :recipes do |t|
      t.remove :image
    end
  end
end
