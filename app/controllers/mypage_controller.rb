# endoing: utf-8

class MypageController < ApplicationController
  before_filter :authenticate_user!

  def index
  end
end
