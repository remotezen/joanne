class AddColumnUserNameToAccounts < ActiveRecord::Migration
  def self.up
    change_table :accounts do |t|
      t.string :user_name
    end
  end

  def self.down
    change_table :accounts do |t|
      t.remove :user_name
    end
  end
end
