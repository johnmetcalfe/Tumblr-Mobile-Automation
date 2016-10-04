require 'spec_helper.rb'

describe "EpicHR Tests" do
  before :each do
    # start an appium session using the desired capabilities set in the spec_helper.rb file
    # launch the appium app
    Appium::Driver.new(desired_capabilities).start_driver

    # adds the appium methods to the methods available for RSpec
    Appium.promote_appium_methods RSpec::Core::ExampleGroup
  end

  after :all do
    # quit the driver after the tests are done
    #driver_quit
  end

  context "Created Alarm" do
    it "Setting an alarm" do
      text("Add alarm").click
      textfields.first.clear
      textfields.first.type "4"
      textfields[1].clear
      textfields[1].type "55"
      textfields.last.clear
      textfields.last.type "P"
      find_element(id: 'button1').click
      text('Vocal Message').click
      find_element(id: 'idtext').type "Time to get that ass up!"
      hide_keyboard
      find_element(id: 'save').click
      find_element(id: 'alarm_save').click




    end
  end
end
