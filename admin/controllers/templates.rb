CssTemplate::Admin.controllers :templates do
  get :index do
    @title = "Templates"
    @templates = Template.all
    render 'templates/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'template')
    @template = Template.new
    render 'templates/new'
  end

  post :create do
    @template = Template.new(params[:template])
    if @template.save
      image_path = save_image(params['image'])
      zip_path = save_zip(params['zip'])
      @template.update(:image_path => image_path, :zip_path => zip_path)
      @title = pat(:create_title, :model => "template #{@template.id}")
      flash[:success] = pat(:create_success, :model => 'Template')
      params[:save_and_continue] ? redirect(url(:templates, :index)) : redirect(url(:templates, :edit, :id => @template.id))
    else
      @title = pat(:create_title, :model => 'template')
      flash.now[:error] = pat(:create_error, :model => 'template')
      render 'templates/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "template #{params[:id]}")
    @template = Template.find(params[:id])
    if @template
      render 'templates/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'template', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "template #{params[:id]}")
    @template = Template.find(params[:id])
    if @template
      if @template.update_attributes(params[:template])
        flash[:success] = pat(:update_success, :model => 'Template', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:templates, :index)) :
          redirect(url(:templates, :edit, :id => @template.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'template')
        render 'templates/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'template', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Templates"
    template = Template.find(params[:id])
    if template
      if template.destroy
        flash[:success] = pat(:delete_success, :model => 'Template', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'template')
      end
      redirect url(:templates, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'template', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Template"
    unless params[:template_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'template')
      redirect(url(:templates, :index))
    end
    ids = params[:account_ids].split(',').map(&:strip)
    template = Template.find(ids)
    
    if !templates
      flash[:error] = pat(:delete_error, :model => 'template')
    elsif Template.destroy templates
    
      flash[:success] = pat(:destroy_many_success, :model => 'Templates', :ids => "#{ids.to_sentence}")
    end
    redirect url(:templates, :index)
  end
end
