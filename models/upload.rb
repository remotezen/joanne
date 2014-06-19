require 'carrierwave/orm/activerecord'
#class Upload < ActiveRecord::Base
class Upload < CarrierWave::Uploader::Base 
  include CarrierWave::MiniMagick
  permissions 0777
  process :resize_to_fit =>[800,800]
  version :thumb do
    process :resize_to_fill =>[50,50]
  #uploader.url: 'images/uploads'               # size: 800x600
  #uploader.thumb.url: 'images/uploads/thumbs'   # size: 200x200
end
def extension_white_list
    %w(jpg jpeg gif png)
  end

end

