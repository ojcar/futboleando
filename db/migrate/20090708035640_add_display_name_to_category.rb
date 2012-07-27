class AddDisplayNameToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories, :displayname, :string
  end

  def self.down
    remove_column :categories, :displayname
  end
end
