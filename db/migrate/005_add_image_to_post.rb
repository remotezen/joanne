class AddImageToPost < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.string :image
    end
  end

  def self.down
    change_table :posts do |t|
      t.remove :image
    end
  end
end
