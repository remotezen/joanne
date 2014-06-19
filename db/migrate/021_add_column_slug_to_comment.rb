class AddColumnSlugToComment < ActiveRecord::Migration
  def self.up
    change_table :comments do |t|
      t.string :slug
    end
  end

  def self.down
    change_table :comments do |t|
      t.remove :slug
    end
  end
end
