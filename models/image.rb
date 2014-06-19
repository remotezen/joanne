class Image < ActiveRecord::Base
  attr_accessible :image, :recipe_id, :post_id, :image
  belongs_to :posts
  belongs_to :recipes
  validates_presence_of :image
  mount_uploader :image, Uploader
end
