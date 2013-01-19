# encoding: utf-8

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,       "JaE8SCtn5R5qNITANJPIjw",                   "UDCCYsA0WQPXxLFT2jFPNGVhr4YpwYeML9k3TRk"
  provider :facebook,      "452090888159529",                          "4e2ddd2159ed37a093054266b0a71d50",       scope: "manage_notifications,create_event,user_events,friends_events,publish_stream,user_birthday,read_friendlists"
  provider :google_oauth2, "1046178131442.apps.googleusercontent.com", "jS2F9tJHOo2RcRAiZvH-mkbg"
end

# APP_ID = "452090888159529"
# APP_SECRET = "4e2ddd2159ed37a093054266b0a71d50"
# app = FbGraph::Application.new(APP_ID, secret: APP_SECRET)
# app.get_access_token

# uid = "100002130858178"
# friend = FbGraph::User.fetch(uid, access_token: FACEBOOK_ACCESS_TOKEN)
# friend.notifications
# friend.notification!( :access_token => FACEBOOK_ACCESS_TOKEN, :href => 'http://matake.jp', :template => 'Your friend achieved new badge!' )
# app = FbGraph::Application.new("452090888159529", :secret => "4e2ddd2159ed37a093054266b0a71d50")
# friend = FbGraph::User.fetch(uid)
# app.notify!( friend,:href => 'http://matake.jp',:template => 'Your friend achieved new badge!')

# access token get metho is written below url
# https://github.com/nov/fb_graph/wiki/App-Access-Token
FACEBOOK_ACCESS_TOKEN = "452090888159529|2aLPrLa7PPhxocdT-ECw7SJHkMY"
