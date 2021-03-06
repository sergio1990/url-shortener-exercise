# typed: false
workers Integer(ENV['WEB_CONCURRENCY'] || 1)
threads_count = Integer(ENV['THREAD_COUNT'] || 5)
threads threads_count, threads_count

rackup      Puma::ConfigDefault::DefaultRackup
port        ENV['PORT']     || 4567
environment ENV['RACK_ENV'] || 'development'
