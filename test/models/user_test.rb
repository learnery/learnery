require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "can be created with e-mail only" do
    u = User.create!( :email => 'me@somewhere.com', :password => '12345678' )
    assert u.valid?
  end
  test "can be created with e-mail, nickname and full name only" do
    u = User.create!( email: 'me@somewhere.com', nickname: 'nick', firstname: 'nikolaus', lastname: 'ps', :password => '12345678' )
    assert u.valid?
  end
end
