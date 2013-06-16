require 'test_helper'

class UserTest < ActiveSupport::TestCase

  describe "admin creation" do 
    it "if there are no admins yet, anyone can become admin" do
      assert User.can_become_admin?, "there are no users yet, anyone can become admin"
      u = create(:user)
      assert User.can_become_admin?, "there are users, bot no admins yet, anyone can become admin"
      u = create(:admin_user)
      refute User.can_become_admin?, "there is an admin already, do not allow just anyone to become admin"
    end
  end

  describe "user creation" do
    it "can be created with e-mail" do
      u = User.create!( :email => 'me@somewhere.com', :password => '12345678' )
      assert u.valid?
    end
    it "can be created with e-mail, nickname and full name" do
      u = User.create!( email: 'me@somewhere.com', nickname: 'nick', firstname: 'nikolaus', lastname: 'ps', :password => '12345678' )
      assert u.valid?
    end
  end

  describe "user info" do
    it "is nickname if present" do
      user = create(:user)
      assert user.nickname == user.user_info
    end
    it "is nickname if only nickname present" do
      user = create(:user_only_with_nickname)
      assert user.nickname == user.user_info
    end
    it "is email if no nickname" do
      user = create(:user_only_with_email)
      assert user.email == user.user_info
    end
  end
end
