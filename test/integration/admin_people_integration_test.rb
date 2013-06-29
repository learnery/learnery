require "test_helper"

describe "Admin People Integration Test" do
  before do
    @user1 = create(:user)
    @user2 = create(:user)
    @user3 = create(:user)
    @admin = create(:admin_user)
  end
  it "normal user cannot see list of all users" do
    login_user( @user1 )
    wont_have_link t("people")

    visit learnery.people_path
    must_have_content t(:admin_only)
  end

  it "admin can see list of all users" do
    login_user( @admin )
    click_link t("people")
    must_have_content @admin.nickname
    must_have_content @user1.nickname
    must_have_content @user2.nickname
    must_have_content @user3.nickname
  end
end # describe "Admin Integration Test"
