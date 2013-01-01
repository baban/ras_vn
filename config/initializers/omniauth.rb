# encoding: utf-8

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,       "JaE8SCtn5R5qNITANJPIjw",                   "UDCCYsA0WQPXxLFT2jFPNGVhr4YpwYeML9k3TRk"
  provider :facebook,      "452090888159529",                          "4e2ddd2159ed37a093054266b0a71d50",       scope: "user_birthday,read_friendlists"
  provider :google_oauth2, "1046178131442.apps.googleusercontent.com", "jS2F9tJHOo2RcRAiZvH-mkbg"
end

