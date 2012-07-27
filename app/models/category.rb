class Category < ActiveRecord::Base
  has_many :posts, :dependent => :nullify
end
