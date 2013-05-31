require "test_helper"

describe "Admin Integration Test" do
 
  it "first user can become admin" do
    user = User.create!( :email => 'user@example.com', :password => '12345678')
    login_user( user )
    page.must_have_content  t(:logged_in_as, :user => user.email)
    click_link t(:logged_in_as, :user => user.email)

    check   t("activerecord.attributes.user.admin")
    fill_in t("activerecord.attributes.user.current_password"), :with => '12345678'

    click_button t(:update)

    page.must_have_content t('devise.registrations.updated')
    user.reload
    assert user.admin, "user is now an admin"
  end

  it "If there's already an admin you can't become admin" do
    admin = User.create!( :email => 'admin@example.com', :password => '12345678', :admin => true )
    user  = User.create!( :email => 'user@example.com',  :password => '12345678')
    login_user( user )

    click_link t(:logged_in_as, :user => user.email)

    page.wont_have_content "Admin"
  end
 
  it "admin can make other user an admin" do
    admin = User.create!( :email => 'admin@example.com', :password => '12345678', :admin => true )
    user  = User.create!( :email => 'user@example.com',  :password => '12345678')
    login_user( admin )

    click_link t(:logged_in_as, :user => admin.email)

    page.must_have_link t("people")
    click_link t("people")

    within "#person_#{user.id}" do
      must_have_content t(:edit)
      click_link t(:edit)
    end

    check t("activerecord.attributes.user.admin")

    click_button t(:update)
    user.reload
    assert user.admin, "user is now an admin"
  end
 
end
