require 'cucumber'
require 'selenium-webdriver'
require 'capybara/dsl'

World Capybara::DSL

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome,
	    :desired_capabilities => Selenium::WebDriver::Remote::Capabilities.chrome(
	      'chromeOptions' => {
	        'args' => [ "--start-maximized"]
	      }
	    )
	)
end

Capybara.configure do |config|
  Capybara.current_driver = :selenium
  config.default_max_wait_time = 6
end
