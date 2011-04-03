require 'openid/store/filesystem'

if Rails.env == "production"
  ActionController::Dispatcher.middleware.use OmniAuth::Builder do
    provider :facebook, FACEBOOK_PROD_APP_ID, FACEBOOK_PROD_APP_SECRET, {:scope =>"publish_stream,offline_access"}
    provider :twitter, TWITTER_PROD_API_KEY, TWITER_PROD_API_SECRET
  end
else
  ActionController::Dispatcher.middleware.use OmniAuth::Builder do
    provider :facebook, FACEBOOK_DEV_APP_ID, FACEBOOK_DEV_APP_SECRET, {:scope =>"publish_stream,offline_access"}
    provider :twitter, TWITTER_DEV_API_KEY, TWITER_DEV_API_SECRET
  end
end

