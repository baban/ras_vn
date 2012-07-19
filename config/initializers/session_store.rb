# Be sure to restart your server when you modify this file.

# RasVn::Application.config.session_store :cookie_store, key: '_ras_vn_session'
RasVn::Application.config.cache_store= :dalli_store, 'localhost:11211'

Rails.application.config.session_store ActionDispatch::Session::CacheStore, expire_after: 3.weeks

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# RasVn::Application.config.session_store :active_record_store
