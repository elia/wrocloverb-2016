require 'bundler/setup'
require 'opal'
require 'inesita'

Opal.append_path 'opal'

run Opal::Server.new { |server|
  server.sprockets.cache = Sprockets::Cache::FileStore.new('tmp/cache')
  server.debug = true
  server.main = 'app'
}
