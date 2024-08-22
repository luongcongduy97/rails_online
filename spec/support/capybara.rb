# spec/support/capybara.rb

Capybara.server = :puma, { Silent: true }

Capybara.javascript_driver = :selenium_chrome_headless
Capybara.app_host = 'http://localhost'

options = Selenium::WebDriver::Chrome::Options.new(
  args: %w[headless disable-gpu no-sandbox disable-dev-shm-usage window-size=1400,1400]
)

Capybara.register_driver(:selenium_chrome_headless) do |app|
  Capybara::Selenium::Driver.new(
    app, browser: :chrome, options:,
         clear_local_storage: true, clear_session_storage: true
  )
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by(:selenium_chrome_headless)
  end
end
