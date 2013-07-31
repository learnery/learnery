require "test_helper"
module Learnery
  describe "Version and Footer Integration Test" do
    it "contains version info" do
      visit learnery.root_path
      page.must_have_content("version info")
    end
    it "contains version from generated version file" do
      visit learnery.root_path
      page.must_have_content("This is learnery version dummy test.")
    end
    it "contains footer" do
      visit learnery.root_path
      page.must_have_content("footer")
    end
  end
end
