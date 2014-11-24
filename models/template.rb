class Template < ActiveRecord::Base

  def self.image_root_path
    '/images/templates'
  end

  def self.zip_root_path
    '/zips'
  end
end
