require 'spec_helper.rb'
require 'pry'

describe "Tumblr Tests" do

  before :all do
    @email = "seitgrads@mailinator.com"
    @username = "seitgrads16"
    @password = "t3stacc0unt16"
    @title = "A test title"
    @body = "A test body"
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
  end

  context "Logging out" do
    it 'manages to log out successfully', focus: true do
      login
      find_element(id: 'topnav_account_button').click
      find_element(class: 'android.widget.TextView').click
      text('Settings').click
      sleep (2)
      swipe start_x: 0, start_y: 0, end_x: 0, end_y: 100, duration: 200
      wait_true{text('Sign out')}.click
      text('Yes').click
      expect(wait_true{button("SIGN IN")}.displayed?).to eq true

    end



  end

  context "Posting" do
    it "should allow a logged in user to post a text post", text: true do
      login
      find_element(id: 'composer_fab').click
      find_element(id: 'compose_post_text').click
      find_element(id: 'title').type @title
      find_element(id: 'body').type @body
      find_element(id: 'action_button_wrapper').click
      find_element(id: 'topnav_account_button').click
      find_element(id: 'list_item_blog_container').click
      verify_and_delete(@body)
    end

    it "Should allow the user to reblog a post", reblog: true do

      login
      find_element(id: 'topnav_explore_button_img_active').click
      text('Search Tumblr').click
      find_element(id: 'searchable_action_bar').type "boldlyspookylady\n"
      find_element(id: 'cancel_button').click
      wait_true{find_element(id: 'list_item_blog_avatar')}.click
      find_elements(class: 'android.widget.ImageButton')[1].click
      find_element(id: 'action_button').click
      find_elements(class: 'android.widget.ImageButton')[3].click
      find_elements(class: 'android.widget.ImageButton')[0].click
      verify_and_delete("Hello World!")

    end

    it "Allow the user to like a post", like: true do

      login
      find_element(id: 'topnav_explore_button_img_active').click
      text('Search Tumblr').click
      find_element(id: 'searchable_action_bar').type "boldlyspookylady\n"
      find_element(id: 'cancel_button').click
      find_element(id: 'list_item_blog_avatar').click
      find_elements(class: 'android.widget.ImageButton')[2].click
      find_elements(class: 'android.widget.ImageButton')[3].click
      find_elements(class: 'android.widget.ImageButton')[0].click
      find_element(id: 'topnav_account_button').click
      find_element(id: 'account_title_text').click
      text("Hello World!")
      find_elements(class: 'android.widget.ImageButton')[2].click


    end

  end

end
