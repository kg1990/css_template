CssTemplate::Admin.controllers :domains do

  get :index do
    @domains = Domain.where(:can_use => true).order("created_at desc").limit(100)
    render 'index'
  end

  get '/d/:page' do
    
  end

  get :do_make do
    temp_x = ('a'..'z').to_a
    for i in 0..200
      domain = ''
      for i in 0..5
        domain += temp_x[Random.new.rand(0..25)]
      end
      domain  += ".com"
      x = Domain.where(:domain => domain).limit(1)
      if x.length ==0
        Domain.create(:domain => domain)
      end
    end
    redirect url(:domains, :index)
  end

  get :do_check do
    domains = Domain.where(:checked => false)
    domains.each do |domain|
      DomainWork.perform_async(domain.id) 
    end
    redirect url(:domains, :index)
  end

  get :all_list do
    @domains = Domain.order("created_at desc").limit(500)
    render 'index'
  end

  get :delete_all do
    Domain.where(:can_use => false).destroy_all
    redirect url(:domains, :index)
  end

  get :not_check do
    @domains = Domain.where(:checked => false)
    render 'index'
  end

  get :download_can_use_list do
    content_type 'application/octet-stream'
    domains = Domain.where(:can_use => true)
    data = 'domain\r\n'
    domains.each do |domain|
      data << "#{domain.domain}\r\n"
    end
    attachment('list.txt')
    data
  end
end
