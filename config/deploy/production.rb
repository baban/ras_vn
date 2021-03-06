# encoding: utf-8

# ブランチは開発環境ではdevelop, 本番（ステージング）ではmaster
set :branch, "master"

set(:deploy_to)         { "/var/www/#{application}" }

set :rails_env, "production"

role :web, "localhost"
role :app, "localhost"

role :db, "localhost", :primary => true

set :default_run_options, :pty => true

set :whenever_environment, "production"

