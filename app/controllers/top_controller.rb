# encoding: utf-8

class TopController < ApplicationController
  def index
    restaurant
    render action:'restaurant'
  end

  def restaurant
    @food_genre = [] # FoodGenreMaster.all
  end

  def recipe
  end

  # <%=link_to "リモートテスト", { controller:"top", action:"remote_test", format:'js' }, 
  #                              id:'remote-test', remote: true %>
  def remote_test
  end

end
