# encoding: utf-8

class Omniuser < ActiveRecord::Base
  establish_connection "cook24_users" if [:staging,:production].include?(Rails.env.to_sym)

  has_one :user

  # twitter/facebookに接続後、omniuser.provider, omniuser.uidがなかったときに呼ばれるクラスメソッド
  def self.create_with_omniauth(auth)
    create! do |omniuser|
      omniuser.provider = auth["provider"]
      omniuser.uid = auth["uid"]

      omniuser.user= User.new
      if omniuser.provider == "facebook"
        omniuser.name = auth["info"]["name"]
      else
        omniuser.name = auth["info"]["nickname"]
      end
    end
  end
end
