if Rails.env.staging? or Rails.env.production?
  Airbrake.configure do |config|
    config.ignore_environments = %w(development test)
    config.project_key = "atencionciudadana"
    config.project_id = Rails.application.secrets.errbit['api_key']
    config.host    = Rails.application.secrets.errbit['host']
  end
end
