class AddSlugToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.string :slug
    end
  end

  def self.down
    change_table :posts do |t|
      t.remove :slug
    end
  end
end
