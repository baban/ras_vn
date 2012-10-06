# encoding: utf-8

# ブランチは開発環境ではdevelop, 本番（ステージング）ではmaster
set :branch, "master"

set(:deploy_to) { "/var/www/htdocs/#{application}" }

set :rails_env, "staging"

#role :web, "localhost" 
#role :app, "localhost"
#role :db,  "localhost", primary: true

role :web, "192.168.0.7" 
role :app, "192.168.0.7"
role :db,  "192.168.0.7", primary: true

set :default_run_options, :pty => true

set :whenever_environment, "staging"

