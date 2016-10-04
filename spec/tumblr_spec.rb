require 'spec_helper.rb'
require 'pry'

describe "Tumblr Tests" do

  before :all do
    @email = "seitgrads@mailinator.com"
    @username = "seitgrads16"
    @password = "t3stacc0unt16"
  end

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
    it "outputs a error message when nil values is entered for username" do
      button("SIGN IN").click
      button("Next").click
      expect(textfields).not_to include 'password'
    end

    it "should allow a valid user to login" do
      login
    end

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

    it "doesnt allow the user to login without entering a password" do
      button("SIGN IN").click
      textfield("email").send_keys @email
      button("Next").click
      expect(buttons[0].enabled?).to eq false
      #binding.pry
    end

    it "Attempting Login with valid email and invalid password", hello: true do

      button('SIGN IN').click
      find_element(class: 'android.widget.EditText').type @email
      button('NEXT').click
      find_elements(class: 'android.widget.MultiAutoCompleteTextView').last.type "invalid"
      button('SIGN IN').click
      begin
        text('Incorrect email address or password. Please try again.').displayed?

      rescue
        raise InvalidTextNotFound
      end
    end

    it "should allow a valid user to login", focus: true do
        find_element(id: 'login_button').click
        find_element(id: 'email').type @email
        find_element(id: 'signup_button').click
        find_element(id: 'password').type "#{@password}\n"
        find_elements(id: 'topnav_dashboard_button_img_active')
    end

  end

  context "Posting" do
    it "should allow a logged in user to post a text post" do
      login
    end
  end

end
