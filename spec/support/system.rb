RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium_headless
  end
end

require 'capybara-screenshot/rspec'