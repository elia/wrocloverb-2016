require 'bundler/setup'
Bundler.require

run Opal::Sprockets::Server.new { |server|
  server.append_path 'lib'
  server.append_path 'opal'
  server.append_path 'node_modules'
  server.sprockets.cache = Sprockets::Cache::FileStore.new('tmp/cache')
  server.debug = true
  server.main = 'app'
}
