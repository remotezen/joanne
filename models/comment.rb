class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :account
  validates_presence_of :comment, :length=>{:maximum=>140 }
  
  sifter :or_comment do |string|
    comment.matches("%#{string}%")
  end
  
  before_save :make_slug
  def to_param
    slug
  end
  def slug
    if comment.length <= 24
     slug = prep_slug(comment)
    else
      slug = prep_slug(comment.slice(0,24))
    end
  end
  def make_slug
    self.slug = slug
  end
    def prep_slug(str)
      str.gsub(" ", "-")
    end
end
