require 'bundler/setup'
require 'opal'
require 'inesita'

run Opal::Server.new { |server|
  server.append_path 'lib'
  server.append_path 'opal'
  server.sprockets.cache = Sprockets::Cache::FileStore.new('tmp/cache')
  server.debug = true
  server.main = 'app'
}
