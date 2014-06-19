class AddColumnSlugToRecipes < ActiveRecord::Migration
  def self.up
    change_table :recipes do |t|
      t.string :slug
    end
  end

  def self.down
    change_table :recipes do |t|
      t.remove :slug
    end
  end
end
