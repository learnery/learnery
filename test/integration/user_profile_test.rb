class UserProfileTest < ActionDispatch::IntegrationTest
 
  test "cannot edit without login" do
    user = User.create!( :email => 'user@example.com', :password => '12345678')
    visit "/users/edit"
    page.must_have_content('You need to sign in or sign up before continuing')
  end

  test "cannot edit without password" do
    user = User.create!( :email => 'user@example.com', :password => '12345678')
    login_user( user )

    visit "/users/edit"


    page.must_have_content('Edit User')
    within('#edit_user') do
      fill_in 'Email', :with => 'some@new.address'
      click_button 'Update'
    end

    page.must_have_content("Current passwordcan't be blank")
  end

  test "can edit name" do
    pw    = '12345678'
    nick  = 'some nickname'
    first = 'some firstname'
    last  = 'some lastname'
    user  = User.create!( :email => 'user@example.com', :password => pw)
    login_user( user )

    visit "/users/edit"

    page.must_have_content('Edit User')
    within('#edit_user') do
      fill_in 'Nickname',  :with => nick
      fill_in 'Firstname', :with => first
      fill_in 'Lastname',  :with => last
      fill_in 'Password',  :with => pw
      click_button 'Update'
    end

  end

 
 
 
 
end
