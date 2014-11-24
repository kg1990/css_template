CssTemplate::Admin.controllers :uploads do

  get :index do
    render 'index'
  end

  post 'image' do
    if params['image'][:filename] && params['image'][:tempfile]
      begin
        file_name = params['image'][:filename]
        temp_file = params['image'][:tempfile]
        file_data = temp_file.read
        original_filename = "." + file_name.split(".").last
        if original_filename != '.jpg'
          raise Exception.new('not image file')
        end
        image_path = Padrino.root + "/public/images/templates"
        File.open("#{image_path}/#{file_name}","wb")do |f|
          f.write(file_data)
        end
        flash[:success] = 'upload image file success'
	puts "fewafewa"
      rescue Exception => e
        flash[:error] = e.message
      end
    else
      flash[:error] = 'params error'
    end
    redirect url(:uploads, :index)
  end

  post 'zip' do
    if params[:zip][:filename] && params[:zip][:tempfile]
      begin
        file_name = params['zip'][:filename]
        temp_file = params['zip'][:tempfile]
        file_data = temp_file.read
        original_filename = "." + file_name.split(".").last
        if original_filename != '.rar'
          raise Exception.new('not rar file')
        end
        image_path = Padrino.root + "/public/images/zips"
        File.open("#{image_path}/#{file_name}","wb")do |f|
          f.write(file_data)
        end
        flash[:success] = 'upload zip file success'
      rescue Exception => e
        flash[:error] = e.message
      end
    else
      flash[:error] = 'params error'
    end
    redirect url(:uploads, :index)
  end
end
