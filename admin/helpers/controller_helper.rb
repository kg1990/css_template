require 'net/http'
require 'uri'
CssTemplate::Admin.helpers do
 
  def save_image(image)
    file_name = image[:filename]
    temp_file = image[:tempfile]
    file_data = temp_file.read
    original_filename = "." + file_name.split(".").last
    new_file_name = Time.now.to_i.to_s + original_filename
    image_path = Padrino.root + "/public" + Template.image_root_path
    File.open("#{image_path}/#{new_file_name}","wb")do |f|
      f.write(file_data)
    end
    new_file_name
  end

  def save_zip(zip)
    file_name = zip[:filename]
    temp_file = zip[:tempfile]
    file_data = temp_file.read
    original_filename = "." + file_name.split(".").last
    new_file_name = Time.now.to_i.to_s + original_filename
    zip_path = Padrino.root + "/public" + Template.zip_root_path
    File.open("#{zip_path}/#{new_file_name}","wb")do |f|
      f.write(file_data)
    end
    new_file_name
  end

  def do_chk(domain)
    domain_name = domain.domain
    uri = URI("http://panda.www.net.cn/cgi-bin/check.cgi?area_domain=#{domain_name}")
    res = Net::HTTP.get(uri)
    if res.include?('210')
      domain.update(:can_use => ture, :response => res, :checked => true)
    else
      domain.update(:can_use => false, :response => res, :checked => true)
    end
  end

end
