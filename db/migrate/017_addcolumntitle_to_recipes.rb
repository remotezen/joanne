class AddcolumntitleToRecipes < ActiveRecord::Migration
  def self.up
    change_table :recipes do |t|
      t.string :title
    end
  end

  def self.down
    change_table :recipes do |t|
      t.remove :title
    end
  end
end
