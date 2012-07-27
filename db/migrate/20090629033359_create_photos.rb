class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.references :post
      t.timestamps
    end
    add_index :photos, :post_id
  end

  def self.down
    drop_table :photos
  end
end
