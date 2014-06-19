class CreateLogins < ActiveRecord::Migration
  def self.up
    create_table :logins do |t|
      t.datetime :created_on
      t.datetime :updated_on
      t.integer :account_id
      t.boolean :logged_in, :default => FALSE 
      t.timestamps
    end
  end

  def self.down
    drop_table :logins
  end
end
