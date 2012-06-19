# endoing: utf-8

class MypagesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @profile = current_user.profile
    @visibility = @profile.visibility
  end
end
