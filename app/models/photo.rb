class Photo < ActiveRecord::Base
  belongs_to :post
  
  has_attached_file :data, :styles => { :thumb => "50x50#", :small => "140", :large => "450"}
  
  validates_attachment_presence :data
  validates_attachment_content_type :data, :content_type => ['image/jpeg','image/pjpeg','image/jpg','image/png']
  
  def self.destroy_pics(post, photos)
    Photo.find(photos, :conditions => {:post_id => post}).each(&:destroy)
  end
end
