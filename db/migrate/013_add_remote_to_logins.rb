class AddRemoteToLogins < ActiveRecord::Migration
  def self.up
    change_table :logins do |t|
      t.string :remote
    end
  end

  def self.down
    change_table :logins do |t|
      t.remove :remote
    end
  end
end
