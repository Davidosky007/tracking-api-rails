if Rails.env == "production"
  Rails.application.config.session_store :cookie_store, key: "_authentication_app", domain: "jdh-authentication-app-react.heroku.com"
else 
  Rails.application.config.session_store :cookie_store, key: "_authentication_app"
end