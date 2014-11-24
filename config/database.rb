##
# You can use other adapters like:
#
#   ActiveRecord::Base.configurations[:development] = {
#     :adapter   => 'mysql2',
#     :encoding  => 'utf8',
#     :reconnect => true,
#     :database  => 'your_database',
#     :pool      => 5,
#     :username  => 'root',
#     :password  => '',
#     :host      => 'localhost',
#     :socket    => '/tmp/mysql.sock'
#   }
#
ActiveRecord::Base.configurations[:development] = {
  :adapter   => 'mysql2',
  :encoding  => 'utf8',
  :reconnect => true,
  :database  => 'css_template_development',
  :pool      => 5,
  :username  => 'root',
  :password  => '123456',
  :host      => 'localhost',
  :port      => '3306'
  #:socket    => '/tmp/mysql.sock'

}

ActiveRecord::Base.configurations[:production] = {
  :adapter   => 'mysql2',
  :encoding  => 'utf8',
  :reconnect => true,
  :database  => 'css_template_production',
  :pool      => 5,
  :username  => 'root',
  :password  => '123456',
  :host      => 'localhost',
  :port      => 3306
  #:socket    => '/tmp/mysql.sock'

}

ActiveRecord::Base.configurations[:test] = {
  :adapter   => 'mysql2',
  :encoding  => 'utf8',
  :reconnect => true,
  :database  => 'css_template_test',
  :pool      => 5,
  :username  => 'root',
  :password  => '',
  :host      => 'localhost',
  :socket    => '/tmp/mysql.sock'

}

# Setup our logger
ActiveRecord::Base.logger = logger

if ActiveRecord::VERSION::MAJOR.to_i < 4
  # Raise exception on mass assignment protection for Active Record models.
  ActiveRecord::Base.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL).
  ActiveRecord::Base.auto_explain_threshold_in_seconds = 0.5
end

# Doesn't include Active Record class name as root for JSON serialized output.
ActiveRecord::Base.include_root_in_json = false

# Store the full class name (including module namespace) in STI type column.
ActiveRecord::Base.store_full_sti_class = true

# Use ISO 8601 format for JSON serialized times and dates.
ActiveSupport.use_standard_json_time_format = true

# Don't escape HTML entities in JSON, leave that for the #json_escape helper
# if you're including raw JSON in an HTML page.
ActiveSupport.escape_html_entities_in_json = false

# Now we can establish connection with our db.
ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[Padrino.env])

# Timestamps are in the utc by default.
ActiveRecord::Base.default_timezone = :utc

REDIS_HOST,REDIS_PORT = 'localhost', 6379
Sidekiq.configure_server do |config|
  config.redis = { :namespace => 'manage', :url => "redis://#{REDIS_HOST}:#{REDIS_PORT}/4" }
  #config.redis = ConnectionPool.new(:size => 2, :timeout => 30) do
   # Redis.new(:host => REDIS_HOST, :port => REDIS_PORT, :db => 4)
  #end
  #config.error_handlers << Proc.new {|ex,ctx_hash| Airbrake.notify(ex) }
end

Sidekiq.configure_client do |config|
  #config.redis = ConnectionPool.new(:size => 1, :timeout => 30) do
  #  Redis.new(:host => REDIS_HOST, :port => REDIS_PORT, :db => 4)
  #end
  config.redis = { :namespace => 'manage', :url => "redis://#{REDIS_HOST}:#{REDIS_PORT}/4" }
end
