class Post < ActiveRecord::Base
  sifter :title_or_body_contains do |string|
    title.matches("%#{string}%") | body.matches("%#{string}%")
  end
  
  attr_accessible :image, :image_cache, :remove_image, :title, :body, :account_id, :post_id, :id, :created_at
  #attr_accessible :image,:title, :body, :account_id, :post_id, :id
  belongs_to :account
  has_one :recipe
  has_many :comments, dependent: :destroy
#  has_one :recipe, :dependent: :destroy

  validates_presence_of :title
  validates_presence_of :body
  before_save  :make_slug
  #mount_uploader :image, Uploader
  scope :for_year,  lambda {|year| where('STRFTIME("%Y",created_at) = ?',year)}
  scope :for_month,  lambda {|month| where('STRFTIME("%m",created_at) = ?',month)}
  def to_param
    slug
  end
  def slug
    title.gsub(" ","-")
  end
  def archive_grouping
  end
  def model_name
    self.class.to_s
  end  
    
  private
    def make_slug
      self.slug = slug
    end
 end
