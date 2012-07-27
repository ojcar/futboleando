class Post < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :photos
  acts_as_textiled :body, :extended
  acts_as_taggable
  
  validates_presence_of :title, :body, :category
  validates_length_of :title, :within => 3..255
  validates_length_of :body, :maximum => 400
  validates_length_of :extended, :maximum => 10000
  
  def day
    self.created_at.strftime('%d %b %y')
  end
  
  def before_create
    @attributes['permalink'] = title.downcase.gsub(/\s+/, '_').gsub(/[^a-zA-Z0-9_]+/, '')
  end
  
  def to_param
    "#{id}-#{permalink}"
  end
  
  def self.per_page
    1
  end
  
  def photo_attributes=(photo_attributes)
    photo_attributes.each do |attributes|
      photos.build(attributes)
    end
  end
end
