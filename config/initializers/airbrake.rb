Airbrake.configure do |config|
  config.api_key = Rails.application.secrets.errbit[:api_key]
  config.host    = Rails.application.secrets.errbit[:host]
  config.port    = 443
  config.secure  = config.port == 443
end
