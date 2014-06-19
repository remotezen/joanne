class CreateCounters < ActiveRecord::Migration
  def self.up
    create_table :counters do |t|
      t.integer :hit , default: 0
      t.string  :ip
      t.timestamps
    end
  end

  def self.down
    drop_table :counters
  end
end
