require "test_helper"

describe "Rsvp Integration Test" do
 
  context "seeing rsvp status for a future event" do


    before do
      @e = Event.create!( :name => 'intresting event', :starts => Date.today + 10 )
      @u1 = User.create!( :email => 'user1@example.com', :password => '12345678')
      @u2 = User.create!( :email => 'user2@example.com', :password => '12345678')
      @u3 = User.create!( :email => 'user3@example.com', :password => '12345678')
      @u4 = User.create!( :email => 'user4@example.com', :password => '12345678')

      @r1 = Rsvp.create!( :event => @e, :user => @u1, :answer => :yes )
      @r2 = Rsvp.create!( :event => @e, :user => @u2, :answer => :no )
      @r3 = Rsvp.create!( :event => @e, :user => @u3, :answer => :maybe )
      # no Rsvp for user @u4
    end
 
    it "noone is attending" do
      # TODO: find a way to test this in some themes, and not test it in others
      skip "only applies to some themes"
      @r1.answer = :no
      @r1.save!
      visit event_path(@e)
      page.must_have_content "noone is attending yet - be the first to rsvp!"
    end

    it "one person is attending" do
      # TODO: find a way to test this in some themes, and not test it in others
      skip "only applies to some themes"
      visit event_path(@e)
      page.must_have_content "one person will attend"
    end

    it "one person is attending" do
      # TODO: find a way to test this in some themes, and not test it in others
      skip "only applies to some themes"
      @r2.answer = :yes
      @r2.save!
      visit event_path(@e)
      page.must_have_content "2 people will attend"
    end

  end

  context "rsvping for a future event" do

    before do
      @e = Event.create!( :name => 'intresting event', :starts => Date.today + 10 )
      @u = User.create!( :email => 'user@example.com', :password => '12345678')
    end
 
    it "cannot rsvp without login" do
      visit event_path(@e)
      page.wont_have_button('Update Rsvp')
      page.wont_have_button('Create Rsvp')
    end

    it "user can rsvp" do
      login_user( @u )
      visit event_path( @e )

      page.must_have_button t(:say_yes, :scope => 'activerecord.values.rsvp.answer')
      click_button t(:say_yes, :scope => 'activerecord.values.rsvp.answer')
      page.must_have_content 'You said yes.'

      page.must_have_button t(:say_no, :scope => 'activerecord.values.rsvp.answer')
      click_button t(:say_no, :scope => 'activerecord.values.rsvp.answer')
      page.must_have_content 'You said no.'
    end

  end

end
