# encoding: utf-8

# capistranoの実行結果の色付け
require 'capistrano_colors'

# 環境ごとに設定ファイルを返るgem
require 'capistrano/ext/multistage'

# bundle installを使うため
require "bundler/capistrano"

require "uri"

# wheneverを使う
require "whenever/capistrano"

# アプリケーション名
set :application, "ras_vn"

# exportはgit cloneして .gitを除外
set :deploy_via, :export

# sshのユーザー情報
set :user, "baban"
set :password, "svc2027"
set :use_sudo, false

# バージョン管理(git)
set :scm, :git
set :repository, "~/ras_vn/"
set :scm_username, 'baban'
set :scm_passphrase, "svc2027"

set :runner, "baban"
set :branch, "master"
set :deploy_via, :checkout
set :git_shallow_clone, 1
set :chmod755, "app config db lib public vendor script script/* public/disp*"

set :bundle_gemfile,  "Gemfile"
set :bundle_dir,      ""
set :bundle_flags,    ""
set :bundle_without,  [:development, :test]
set :bundle_cmd,      "bundle"
set :bundle_roles,    [:app]

set :default_environment, {
  'RBENV_ROOT' => '$HOME/.rbenv/bin/rbenv',
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}

# releaseディレクトリを残す数
set :keep_releases, 20

# public以下のjavascriptやCSSファイルのタイムスタンプを更新するコマンドを無効化
set :normalize_asset_timestamps, false

load "deploy/assets"

set :whenever_command, "bundle exec whenever"

after "deploy:restart", "deploy:cleanup"

def restart_task
  run "touch #{current_path}/tmp/restart.txt"
end

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start, :roles => :app, :except => {:no_release => true} do 
  end

  task :stop, :rolse => :app  do
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    restart_task
  end

  # shared以下にアップロード画像のシンボリックリンクを作成する
  task :link_uploads do
  end

  # shared以下にアップロード画像用のディレクトリを作成
  task :mkdir_uploads do
  end

  task :cp_rvmrc do
  end

  namespace :web do
    desc <<-DESC
      This task is rewrited for custom maintenace page.
      Usage:
        $ cap deploy:web:disable

    DESC
    task :disable, :roles => :web, :except => { :no_release => true } do
      *ops = (ARGV.size > 2) ? ARGV[2..ARGV.size] : []
      conf_path = "#{current_path}/config/initializers/maintenance.rb"
      run %Q[ruby #{current_path}/sh/maintenance.rb #{conf_path} #{ops.map{ |s| %Q("#{URI.escape(s)}") }*(' ')}]
      # rails再起動
      restart_task
    end

    task :enable, :roles => :web, :except => { :no_release => true } do
      # 指定したファイルのデータを書き換え
      conf_path = "#{current_path}/config/initializers/maintenance.rb"
      run %Q[ruby #{current_path}/sh/unmaintenance.rb #{conf_path}]
      # rails再起動 
      restart_task
    end
  end
end

# seed用のタスクを追加
desc "run rake db:seed"
namespace :db do
  task :seed, :roles => :db do
    run "cd #{current_path}; bundle exec rake RAILS_ENV=#{rails_env} db:seed"
  end
end

# resque
desc "resque"
namespace :resque do
  task :restart, :roles => :app do
    run "#{current_path}/tmp/restart.txt"
    run "chmod 777 #{current_path}/tmp/restart.txt"
  end
end

