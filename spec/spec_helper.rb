require 'rspec'
require 'pry'
require 'appium_lib'
require 'support'

RSpec.configure do|config|
  config.color = true
  config.tty = true
  config.formatter = :documentation
end

def desired_capabilities
  {
    caps: {
      platformName: "Android",
      deviceName: "emulator-5554",
      app: "./binaries/Tumblr.apk",
      newCommandTimeout:600
    },
    appium_lib: {
      :sauce_username => nil,
      :sauce_access_key => nil
    }
  }
end

def login
  find_element(id: 'login_button').click
  find_element(id: 'email').type @email
  find_element(id: 'signup_button').click
  find_element(id: 'password').type "#{@password}\n"
  # this looks for the 'home' icon in the navbar and checks that it is displayed
  expect(find_element(id: 'topnav_dashboard_button').displayed?).to eq true
end
