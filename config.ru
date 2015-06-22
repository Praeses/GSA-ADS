
#
# simple rack config file for uses in development
# to uses type bundle exec rackup
#

@root = File.expand_path(File.join(File.dirname(__FILE__), "www"))
run Proc.new { |env|
  req = Rack::Request.new(env)
  index_file = File.join(@root, req.path_info, "/views/index.html")
  if File.exists?(index_file)
    req.path_info += "/views/index.html"
  end
  Rack::Directory.new(@root).call(env)
}
