require 'rspec'
require 'pry'
require 'appium_lib'

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
