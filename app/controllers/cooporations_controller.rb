# encoding: utf-8

class CooporationsController < ApplicationController
  def action_missing(name, *_ )
    render action: name
  end
end
