# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
    :namespace => 'sessions',
    :expire_after => 20.minutes.to_i,
    :memcache_server => ['server-1:11211', 'server-2:11211'],
    :key => '_rammi_session',
    :secret => '5cf95911f7b69baec13da3fabf8187d25edbe0b7fc47ad92b23e3b3b568fcddac1362e7a419af12e8af908cd1d770117cfb273c4ab8c822dbc4182d280ddf4f6'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
