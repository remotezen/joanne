class AddPostidIndexToComment < ActiveRecord::Migration
  def self.up
     change_table :comments do |t|
      t.index :post_id, :unique => false
     end
  end

  def self.down
     change_table :comments do |t|
      t.remove_index :post_id
     end
  end
end
