# encoding: utf-8

class TopController < ApplicationController
  def index
    shop
    render action:'shop'
  end

  def shop
    @food_genre = FoodGenreMaster.all
  end

  def recipi
  end

  def restrant
  end

  # <%=link_to "リモートテスト", { controller:"top", action:"remote_test", format:'js' }, 
  #                              id:'remote-test', remote: true %>
  def remote_test
  end

end
