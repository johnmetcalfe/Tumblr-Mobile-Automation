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

    it "should allow a valid user to login" do
      find_element(id: 'login_button').click
      find_element(id: 'email').type @email
      find_element(id: 'signup_button').click
      find_element(id: 'password').type "#{@password}\n"
      expect(wait_true{find_element(id: 'topnav_dashboard_button')}.displayed?).to eq true
    end
  end

  context "Logging out" do
    it 'manages to log out successfully', focus: true do
      button("SIGN IN").click
      textfield("email").send_keys @email
      button("Next").click
      find_elements(class: 'android.widget.MultiAutoCompleteTextView').last.type @password
      find_element(class: 'android.widget.Button' ).click
      wait_true{find_element(id: 'topnav_dashboard_button')}
      find_element(id: 'topnav_account_button').click
      find_element(class: 'android.widget.TextView').click
      text('Settings').click
      sleep (2)
      swipe start_x: 0, start_y: 0, end_x: 0, end_y: 100, duration: 200
      wait_true{text('Sign out')}.click
      text('Yes').click
      expect(wait_true{button("SIGN IN")}.displayed?).to eq true

    end

    it "Attempting Login with valid email and invalid password" do

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

  end

  context "Posting" do
    it "should allow a logged in user to post a text post" do
      login
    end
  end

end
