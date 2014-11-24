# set path to app that will be used to configure unicorn,
# note the trailing slash in this example
@dir = "/www/css_template"

worker_processes 2
working_directory @dir

timeout 30

# Specify path to socket unicorn listens to,
# we will use this in our nginx.conf later
listen "/tmp/unicorn.css.sock", :backlog => 64

# Set process id path
pid "#{@dir}/pids/unicorn.pid"

# Set log file paths
stderr_path "#{@dir}/logs/unicorn.stderr.log"
stdout_path "#{@dir}/logs/unicorn.stdout.log"
