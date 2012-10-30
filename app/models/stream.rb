# encoding: utf-8

class Stream < ActiveRecord::Base
  ADD_RECIPE = 2

  @@trannslaters = {
    # cannot translate data
    0=>->( user_id, *options ){ "" },
    # user registration
    1=>->( user_id, *options ){
      user = User.find_by_id( user_id )
      "<a href='/kitchen/#{user.id}'>新しくユーザー登録がありました</a>"
    },
    # add recipe
    2=>->( user_id, *options ) do
      user = User.find_by_id( user_id )
      recipe = options.first
      "<a href='/recipes/#{recipe.id}'>#{user.profile.nickname} がレシピ[#{recipe.title}]を投稿しました</a>"
    end,
  }

  # add event stream
  # @return [Stream] added event
  def self.push( stream_type, user_id, *options )
    stream = Stream.new
    stream.user_id = user_id
    stream.stream_type = stream_type
    stream.title = @@trannslaters[stream_type].call( user_id, *options )
    stream.save
    stream
  end

  def self.topics
    order("id DESC").page(1).per(5)
  end
end
