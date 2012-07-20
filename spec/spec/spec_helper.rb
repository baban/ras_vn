require 'spork'
require "rspec/expectations"
require 'webmock/rspec'
require 'database_cleaner'

if ENV["COVERAGE"] == "on"
  require 'simplecov'
  if ENV["JENKINS"] == 'on'
    require 'simplecov-rcov'
    SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
  end

  SimpleCov.start 'rails' do
    add_filter "/spec/"
  end
end

Spork.prefork do
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'capybara/rails'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    # == Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
    config.mock_with :rspec

    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = false

    WebMock.disable_net_connect!(:allow_localhost => true)
    Capybara.server_port = 9887 + ENV['TEST_ENV_NUMBER'].to_i
    Capybara.javascript_driver = :webkit

    config.before :each do
      if Capybara.current_driver == :rack_test
        DatabaseCleaner.strategy = :transaction
        DatabaseCleaner.start
      else
        DatabaseCleaner.strategy = :truncation
      end
    end

    config.after :each do
        DatabaseCleaner.clean
    end

    config.include FactoryGirl::Syntax::Methods

    REDIS_PID = "#{Rails.root}/tmp/pids/redis-test#{ENV['TEST_ENV_NUMBER']}.pid"
    REDIS_CACHE_PATH = "#{Rails.root}/tmp/cache/"

    config.before(:suite) do
      redis_options = {
        "daemonize"     => 'yes',
        "pidfile"       => REDIS_PID,
        "port"          => Settings.redis.port,
        "timeout"       => 300,
        "save 900"      => 1,
        "save 300"      => 1,
        "save 60"       => 10000,
        "dbfilename"    => "dump.rdb#{ENV['TEST_ENV_NUMBER']}",
        "dir"           => REDIS_CACHE_PATH,
        "loglevel"      => "debug",
        "logfile"       => "stdout",
        "databases"     => 16
      }.map { |k, v| "#{k} #{v}" }

      if ENV["JENKINS"] == 'on'
        require 'tempfile'
        temp = Tempfile::new("redis_temp.conf", REDIS_CACHE_PATH)
        redis_options.each do |value|
          temp.puts(value)
        end

        temp.close

        Subexec.run("redis-server #{temp.path}")
      else
        redis_options = redis_options.join("\n")
        `echo '#{redis_options}' | redis-server -`
      end
    end

    config.after(:suite) do
      %x{
        cat #{REDIS_PID} | xargs kill -QUIT
        rm -f #{REDIS_CACHE_PATH}dump.rdb#{ENV['TEST_ENV_NUMBER']}
      }
    end

    #config.before(:all) do
    #  unless ENV["JENKINS"] == 'on'
    #    DeferredGarbageCollection.start
    #  end
    #end

    #config.after(:all) do
    #  unless ENV["JENKINS"] == 'on'
    #    DeferredGarbageCollection.reconsider
    #  end
    #end

    #config.before(:all) do
    #  DatabaseCleaner.strategy = :truncation
    #  DatabaseCleaner.start
    #end

    #config.after(:all) do
    #  DatabaseCleaner.clean  
    #  #FileUtils.rm_rf(Dir["#{Rails.root}/spec/support/uploads"])
    #end
  end

  if Spork.using_spork?
    ActiveSupport::Dependencies.clear
    ActiveRecord::Base.instantiate_observers
  end
end

Spork.each_run do
  FactoryGirl.reload
  Deadend::Application.reload_routes!

  #class ActiveRecord::Base
  #  mattr_accessor :shared_connection
  #  @@shared_connection = nil

  #  def self.connection
  #    @@shared_connection || retrieve_connection
  #  end
  #end
  #ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection


end

#class ActiveRecord::Base
#  mattr_accessor :shared_connection
#  @@shared_connection = nil
# 
#  def self.connection
#    @@shared_connection || retrieve_connection
#  end
#end
# 
#ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
