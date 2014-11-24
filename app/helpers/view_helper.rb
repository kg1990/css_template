CssTemplate::App.helpers do
  
  def get_download_href(zip_path)
    Template.zip_root_path + "/" + zip_path
  end

  def get_image_href(image_path)
    Template.image_root_path + "/" + image_path
  end

  def format_time(created_at)
    created_at.strftime('%Y-%m-%d')
  end
end
