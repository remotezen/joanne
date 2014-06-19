class Topping < ActiveRecord::Base
  belongs_to :recipe
  validates_presence_of :description, :ingredients, :title
  #validates_uniqueness_of :title

end
