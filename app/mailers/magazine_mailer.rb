# encoding: utf-8

class MagazineMailer < ActionMailer::Base
  default from: "info@cook24.vn"

  def magazine( profile, buffer )
    @buffer = buffer
    @profile = profile

    mail( subject: @buffer.title, from: @buffer.from, to: @profile.email, 'Reply-to' => @buffer.reply_to )
  end

  def recipe_magazine( profile, tmpl, recipe )
    @recipe  = recipe 
    @tmpl    = tmpl 
    @profile = profile

    mail( subject: "【れぴまが】#{recipe.title}", to: @profile.email )
  end

end
