CssTemplate::App.helpers do
 
  def get_random_templates
    templates = []
    count = Template.last.id
    while templates.length < 4
      random_id = Random.new.rand(1..count)
      x = Template.where(:id => random_id)
      if x.length > 0
        templates << x[0]
      end
    end
    templates
  end


end
