
source 'https://rubygems.org'

gem 'rails', '3.2.2'

gem 'mysql2', '0.3.11'

# view urilities
gem 'jquery-rails'

gem 'devise', "2.1.0" # add login, logout 
gem 'typus', "3.1.10" # generte administration functions
gem "formtastic", "2.1.0"

# controller, model tools
gem "aspectr"  # add aspect oriented programming functions
gem 'jbuilder'
gem 'bcrypt-ruby', '~> 3.0.0'
#gem "rmagick" # image-magick ruby module

# ruby extentions
gem "tapp" # add tapp(tap print) method
gem 'i18n_generators', "1.2.1" # gemerate multiple language message file
gem "ruby-openid", "2.1.8" # openid
gem "rails3_acts_as_paranoid", "0.2.4" # 論理削除を簡単に行えるようにする
gem "ipaddress", '0.8.0' # ipアドレスチェック
gem 'jpmobile', '3.0.1', require:'action_pack' # emable smart_phone_filter 
gem "yard", '0.7.4' # document generator like javadoc
#gem "guard" # ユニットテストの結果をデスクトップに通知
#gem "guard-rspec"

# test utilities
gem 'rspec' # unit test utilities
gem 'rspec-rails'
gem 'flextures', "1.9.12" # add rake command for dump and load fixtures
gem 'faker' # generate fake data
gem 'faker-japanese' # generate japanese names
gem "spork"
gem "factory_girl_rails" # unit test data generate utilities
gem "kaminari" # paginate view
gem "whenever", '0.7.2', require:false # cron設定の追加＆削除自動化
gem 'capistrano', '2.9.0'
gem 'capistrano_colors', '0.5.5'
gem 'capistrano-ext', '1.2.1'
gem 'acts_as_readonlyable', '0.0.9' # DBのマスタースレーブ分割

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

group :test do
  gem 'turn', '0.8.2', require:false # Pretty printed test output
  #gem "spork", "0.9.0" # rspec高速起動
  gem "simplecov", "0.5.4", require:false # テスト結果整形出力
  gem "simplecov-rcov", "0.2.3", require:false
  gem 'capybara' # 受け入れテスト記述、実行ツール
end

group :development, :test do
  gem "pry"
  gem "pry-doc"
  gem "pry-rails"
  gem 'plymouth', require: false
  #gem 'pry-exception_explorer'
  #gem 'pry-nav'
  #gem 'pry-remote'
  #gem 'pry-stack_explorer'
  #gem 'ruby-debug19'
  #gem 'ruby-debug-base19x', '>= 0.11.30.pre10'
  #gem 'linecache19', git: 'https://github.com/mark-moseley/linecache.git', ref: '869c6a65155068415925067e480741bd0a71527e'
end

