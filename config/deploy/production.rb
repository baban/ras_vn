# -*- coding: utf-8 -*-

# ブランチは開発環境ではdevelop, 本番（ステージング）ではmaster
set :branch, "master"

set(:deploy_to)         { "/var/www/#{application}" }

set :rails_env, "production"

role :web, "180.93.7.89"
role :app, "180.93.7.89"

role :db, "180.93.7.89", :primary => true

set :default_run_options, :pty => true

set :whenever_environment, "production"

