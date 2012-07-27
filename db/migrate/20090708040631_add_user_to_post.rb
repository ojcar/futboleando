class AddUserToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :user_id, :int
  end

  def self.down
    remove_column :posts, :user_id
  end
end
