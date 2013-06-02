require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "if there are no admins yet, anyone can become admin" do
    assert User.can_become_admin?, "there are no admins yet, anyone can become admin"
    u = User.create!( :email => 'me@somewhere.com', :password => '12345678', :admin => true )
    refute User.can_become_admin?, "there is an admins yet, do not allow anyone to become admin"
  end
  test "can be created with e-mail" do
    u = User.create!( :email => 'me@somewhere.com', :password => '12345678' )
    assert u.valid?
  end
  test "can be created with e-mail, nickname and full name" do
    u = User.create!( email: 'me@somewhere.com', nickname: 'nick', firstname: 'nikolaus', lastname: 'ps', :password => '12345678' )
    assert u.valid?
  end

  describe "user info" do
    it "is username if present" do
      user = create(:user)
      assert user.username == user.user_info
    end
    it "is username if only username present" do
      user = create(:user_only_with_username)
      assert user.username == user.user_info
    end
    it "is email if no username" do
      user = create(:user_only_with_email)
      assert user.email == user.user_info
    end
  end
end
