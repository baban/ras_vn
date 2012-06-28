# encoding: utf-8

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,"zardckTK9Vhtw785NlYXpA","HGLKtPNkDxYRfrFeNvDmpfYsTY1VEvQNxqHT5t5kmf4"
  provider :facebook,"317242041700524","220d33961f61e6375e6e758a73822dc5"
end

