# encoding: utf-8

class MagazineMailer < ActionMailer::Base
  default from: "info@cook24.vn"

  def magazine( buffer )
    @buffer = buffer

    mail( subject: buffer.subject, to: buffer.to, from: buffer.from )
  end

  def recipe_magazine( profile, tmpl, recipe )
    @recipe  = recipe 
    @tmpl    = tmpl 
    @profile = profile

    mail( subject: "【れぴまが】#{recipe.title}", to: @profile.email )
  end

end
