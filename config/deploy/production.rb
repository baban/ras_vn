# -*- coding: utf-8 -*-

# ブランチは開発環境ではdevelop, 本番（ステージング）ではmaster
set :branch, "master"

set(:deploy_to)         { "/var/www/htdocs/#{application}" }

set :rails_env, "production"

role :web, "192.168.131.164", "192.168.131.169"
role :app, "192.168.131.164", "192.168.131.169"

role :db, "192.168.131.164", :primary => true

set :default_run_options, :pty => true

set :whenever_environment, "production"

