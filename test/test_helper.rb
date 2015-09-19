ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails/capybara'
require 'minitest/reporters'

Minitest::Reporters.use!
Capybara.javascript_driver = :webkit
include Warden::Test::Helpers
Warden.test_mode!

#class ActiveSupport::TestCase
class ActionController::TestCase
  include Devise::TestHelpers
  include FactoryGirl::Syntax::Methods
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
end

DatabaseCleaner.strategy = :truncation

class Minitest::Spec
  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
end

Capybara::Webkit.configure do |config|
  config.block_unknown_urls
end

