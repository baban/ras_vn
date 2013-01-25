# encoding: utf-8

class Admin::MailTemplatesController < Admin::ResourcesController

  def create
    if params[:squueze_ranking]
      @item = MailTemplate.new
      @item.content = "hhhhh"
      
      return render action:"new"
    else
      super
    end
  end

  def update
    if params[:squueze_ranking]
      super
      @item.content = "hhhhh"
    else
      super
    end
  end

end
