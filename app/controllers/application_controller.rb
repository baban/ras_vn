# encoding: utf-8

class ApplicationController < ActionController::Base
  include FormHelper

  before_filter :sidebar_filter
  before_filter :analyze_log_filter

  protect_from_forgery

  helper_method :my_recipe?, :current_omniuser, :login?

  @@analyze_logger = Logger.new("log/analyze.log")

  def auth
    @user = current_user
  end

  private
  def my_recipe?
    @recipe and (@recipe.user_id == current_user.id)
  end

  # Omniauthでのログイン状況確認
  def current_omniuser
    @current_omniuser ||= Omniuser.find_by_id(session[:user_id]) if session[:user_id]
  end

  def login?
    !!current_user
  end

  def sidebar_filter
    @newsfeeds = Newsfeed.topics
    @streams = Stream.topics
  end

  def analyze_log_filter
    log = %W|#{request.ip} - - [#{Time.now.strftime('%d/%M/%Y %H:%m:%S')}] "#{request.method} #{request.path}" HTTP/1.1 200 44 "http://localhost/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:15.0) Gecko/20100101 Firefox/15.0.1"|
    # 192.168.0.3 - - [11/Oct/2012:01:45:09 +0900] "GET /uploads/newsfeed/image/4/thumb_sp03.jpg HTTP/1.1" 404 728 "http://192.168.0.10/recipes/220" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:15.0) Gecko/20100101 Firefox/15.0.1"
    @@analyze_logger.info log
  end
end
