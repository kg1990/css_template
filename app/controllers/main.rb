CssTemplate::App.controllers do
  get :index do
    @per_page = 12
    count = Template.count
    @total = count/@per_page + (count%@per_page > 0 ? 1 : 0)
    @current_page = 1
    @templates = Template.order('created_at desc').offset(0).limit(@per_page)
    puts @total
    render 'main/index'
  end

  get 'd/:page' do
    @current_page = params[:page].to_i
    @per_page = 12
    count = Template.count
    @total = count/@per_page + (count%@per_page > 0 ? 1 : 0)
    @templates = Template.order('created_at desc').offset((@current_page - 1) * @per_page).limit(@per_page)
    render 'main/index'
  end

  get 'detail/:id' do
    halt 404 unless @template = Template.find(params[:id])
    @template.update(:view_count => @template.view_count + 1)
    @random_templates = get_random_templates
    render 'main/detail'
  end

  get :about do
    render 'main/about'
  end

  get :contact do
    render 'main/contact'
  end

  get :service do
    render 'main/service'
  end

end
