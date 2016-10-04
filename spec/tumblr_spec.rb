require 'spec_helper.rb'
describe "Tumblr Tests" do
  before :each do
    # start an appium session using the desired capabilities set in the spec_helper.rb file
    # launch the appium app
    Appium::Driver.new(desired_capabilities).start_driver

    # adds the appium methods to the methods available for RSpec
    Appium.promote_appium_methods RSpec::Core::ExampleGroup
  end

  after :all do
    # quit the driver after the tests are done
    driver_quit

  end

  context "Logging in" do
    it "Attempting Login with invalid Email" do

      button('SIGN IN').click
      find_element(class: 'android.widget.EditText').type "hello.com"
      button('NEXT').click
      begin
        find_element(class: 'android.widget.MultiAutoCompleteTextView')

        raise PasswordFieldFound
      rescue Selenium::WebDriver::Error::NoSuchElementError
        # Don't do anyting AKA Pass
      end

    end

    it "Attempting Login with valid email and invalid password" do

      button('SIGN IN').click
      find_element(class: 'android.widget.EditText').type "john.metcalfe@skybettingandgaming.com"
      button('NEXT').click
      find_elements(class: 'android.widget.MultiAutoCompleteTextView').last.type "invalid"
      button('SIGN IN').click
      begin
        text('Incorrect email address or password. Please try again.').displayed?

      rescue
        raise InvalidTextNotFound
      end

    end

  end
end
