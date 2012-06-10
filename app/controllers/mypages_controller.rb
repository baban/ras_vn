# endoing: utf-8

class MypagesController < ApplicationController
  before_filter :authenticate_user!

  def index
  end
end
