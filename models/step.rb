class Step < ActiveRecord::Base

  belongs_to :recipe

  attr_accessible :image, :image_cache, :remove_image, :description, :title, :recipe_id
  belongs_to :recipe
  validates_presence_of :description
  #validates_presence_of :title, :uniqueness => true
 # mount_uploader :image, Uploader
  

end
