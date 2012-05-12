# encoding: utf-8

class CooporationController < ApplicationController
  def action_missing(name, *_ )
    render action: name
  end
end
