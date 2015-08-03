Airbrake.configure do |config|
  config.api_key = Rails.appplication.secrets.errbit[:api_key]
  config.host    = Rails.appplication.secrets.errbit[:host]
  config.port    = 443
  config.secure  = config.port == 443
end
