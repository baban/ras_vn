# encoding: utf-8

class Stream < ActiveRecord::Base
  @@trannslaters = {
    # cannot translate data
    0=>->( user_id, *options ){ "" },
    # user registration
    1=>->( user_id, *options ){
      user = User.find_by_id( user_id )
      "新しくユーザー登録がありました"
    },
    # add recipe
    2=>->( user_id, *options ) do
      user = User.find_by_id( user_id )
      recipe = options.first
      "#{user.profile.nickname} がレシピ[#{recipe.title}]を投稿しました"
    end,
  }

  # add event stream
  # @return [Stream] added event
  def self.push( stream_type, user_id, *options )
    stream = Stream.new
    stream.user_id = user_id
    stream.stream_type = stream_type
    stream.save
    stream.title = @@trannslaters[stream_type].call( user_id, *options )
    stream.option_data = {}
    stream
  end
end
