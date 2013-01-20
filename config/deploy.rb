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
set :application, "cook24.vn"

# exportはgit cloneして .gitを除外
set :deploy_via, :export

# sshのユーザー情報
set :user, "cook24"
set :password, "qawsedrf"
set :use_sudo, true

# バージョン管理(git)
set :scm, :git
set :repository, "~/cook24/"
set :scm_username, 'cook24'
set :scm_passphrase, "qawsedrf"

set :runner, "cook24"
set :branch, "master"
set :deploy_via, :checkout
set :git_shallow_clone, 1
set :chmod755, "app config db lib public vendor script script/* public/disp*"

# releaseディレクトリを残す数
set :keep_releases, 5

# public以下のjavascriptやCSSファイルのタイムスタンプを更新するコマンドを無効化
set :normalize_asset_timestamps, false

load "deploy/assets"

set :whenever_command, "bundle exec whenever"

after "deploy:restart", "deploy:cleanup"
after "deploy:symlink", "deploy:image_symlink"

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
  task :image_symlink do
    run "rm -rf #{current_path}/public/uploads"
    run "ln -s -f #{deploy_to}/shared/uploads #{current_path}/public/uploads"
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

