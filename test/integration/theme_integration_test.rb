require "test_helper"
require 'RMagick'

SCREENSHOT_DIR = 'tmp'
SCREENSHOT_FILENAME = File.join(SCREENSHOT_DIR,'screenshot.png')
OUT_FILENAME = File.join(SCREENSHOT_DIR,'out.png')
COMPARE_FILENAME = File.join(SCREENSHOT_DIR,'compare.png')

describe "Theme Integration Test" do
  setup do
    Capybara.current_driver = Capybara.javascript_driver # :selenium by default
  end

  it "may take a screenshot" do

    FIXTURE_FILENAME = ENV['LEARNERY_THEME']? ENV['LEARNERY_THEME'] : "default"
    screenshot_fixture_file  = "test/fixtures/screenshots/#{FIXTURE_FILENAME}.png"
    screenshot_fixture_image = Magick::Image::read(screenshot_fixture_file).first

    visit learnery.root_path
    save_screenshot(SCREENSHOT_FILENAME)
    image = Magick::Image.read(SCREENSHOT_FILENAME).first
    image_right_size = image.resize_to_fill(screenshot_fixture_image.columns, screenshot_fixture_image.rows, Magick::NorthWestGravity)
    image_right_size.write(OUT_FILENAME)

    ilg = Magick::ImageList.new
    ilg.push( screenshot_fixture_image )
    ilg.push( image_right_size )
    ilg.append(true).write(COMPARE_FILENAME)

    errors= image_right_size.difference( screenshot_fixture_image )
    assert_in_delta( errors[1], 0, 0.1 )
  end

end
