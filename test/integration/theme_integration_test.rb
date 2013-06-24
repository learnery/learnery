require "test_helper"
require 'RMagick'

describe "Theme Integration Test" do
  setup do
    Capybara.current_driver = Capybara.javascript_driver # :selenium by default
  end

  it "may take a screenshot" do
    screenshot_file_name = ENV['LEARNERY_THEME']? ENV['LEARNERY_THEME'] : "default"
    screenshot_fixture_file  = "test/fixtures/screenshots/#{screenshot_file_name}.png"
    screenshot_fixture_image = Magick::Image::read(screenshot_fixture_file).first

    visit root_path
    save_screenshot('screenshot.png')
    image = Magick::Image.read('screenshot.png').first
    image_right_size = image.resize_to_fill(screenshot_fixture_image.columns, screenshot_fixture_image.rows, Magick::NorthWestGravity)
    image_right_size.write('out.png')

    ilg = Magick::ImageList.new
    ilg.push( screenshot_fixture_image )
    ilg.push( image_right_size )
    ilg.append(true).write("compare.png")

    errors= image_right_size.difference( screenshot_fixture_image )
    assert_in_delta( errors[1], 0, 0.1 )
  end

end
