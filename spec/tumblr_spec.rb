require 'spec_helper.rb'

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
    it "should allow a valid email address" do
      find_element(id: 'login_button').click
      find_element(id: 'email').type @email
      find_element(id: 'signup_button').click
      find_element(id: 'password').type "#{@password}\n"
      expect(find_element(id: 'topnav_dashboard_button').displayed?).to eq true
    end
  end
end
