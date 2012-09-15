
source 'https://rubygems.org'

gem 'rails', '3.2.2'

gem "mysql2", "0.3.11"
gem "memcache-client", "1.8.5" # user memcashed
gem "dalli", "2.1.0"           # memcached hig-perfirmance settinged gem
gem "redis", "3.0.1"
#gem "mongo_mapper"
gem "fluentd"
gem "bartt-ssl_requirement", "1.4.2", require: "ssl_requirement"
gem "rails_config"
gem "fluent-plugin-mongo"

# view urilities
gem "jquery-rails"

gem "devise", "2.1.0" # add login, logout 
gem "typus", "3.1.10" # generte administration functions
gem "formtastic", "2.1.0"
gem "omniauth", "1.1.0"
gem "omniauth-twitter", "0.0.9"
gem "omniauth-facebook", "1.4.0"
gem "omniauth-google-oauth2", "0.1.10"

# controller, model tools
gem "aspectr"  # add aspect oriented programming functions
gem 'jbuilder'
gem 'bcrypt-ruby', '~> 3.0.0'
gem "mini_magick", "3.4"
gem "carrierwave", "0.6.2"

# ruby extentions
gem "tapp" # add tapp(tap print) method
gem 'i18n_generators', "1.2.1" # gemerate multiple language message file
gem "ruby-openid", "2.1.8" # openid
gem "rails3_acts_as_paranoid", "0.2.4" # logical
gem "ipaddress", '0.8.0' # ip addres check
gem 'jpmobile', '3.0.1', require:'action_pack' # emable smart_phone_filter 
#gem "yard", '0.7.4' # document generator like javadoc
#gem "guard" # notification rspec excute result (Mac only)
#gem "guard-rspec"

# test utilities
gem 'flextures', "2.0.1" # add rake command for dump and load fixtures
gem "kaminari" # paginate view
gem "whenever", '0.7.2', require:false # cron settiing automation 
gem "acts_as_readonlyable", '0.0.9' # sharding slave databases

gem "capistrano", "2.9.0"
gem "capistrano_colors", "0.5.5"
gem "capistrano-ext", "1.2.1"
gem "rvm-capistrano"

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
  gem "jasmine-rails"
  gem 'rspec' # unit test utilities
  gem 'rspec-rails'
  gem 'faker' # generate fake data for test
  gem 'faker-japanese' # generate fake japanese names for test
  gem "factory_girl_rails" # unit test data generate utilities
  gem "shoulda"
end

group :test do
  gem 'turn', '0.8.2', require:false # Pretty printed test output
  gem "spork", "0.9.1" # rspec
  gem "simplecov", "0.5.4", require:false # test covarage files generate
  gem "simplecov-rcov", "0.2.3", require:false
  gem "capybara" # test driver
end

group :development, :test do
  gem 'sextant'
  gem "pry" # add commands [rails colsole]
  gem "pry-doc"
  gem "pry-rails"
  gem 'plymouth', require: false
  gem 'pry-exception_explorer'
  gem 'pry-nav'
  gem 'pry-remote'
  gem 'pry-stack_explorer'
end

