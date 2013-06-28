require "test_helper"

describe "Rsvp Integration Test" do

  context "create rsvps only if needed" do
    before do
      @e = create( :event )
      @u = create( :user )
    end

    it "if i just visit the events page no rsvp is created" do
      login_user( @u )
      visit event_path( @e )
      @e.rsvp_of( @u ).must_be_nil
    end

    it "if i click rspv an rsvp is created" do
      login_user( @u )
      visit event_path( @e )

      click_button t(:say_yes, :scope => 'activerecord.values.rsvp.answer')
      @e.rsvp_of( @u ).wont_be_nil
    end
  end # context "create rsvps only if needed"

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
      page.must_have_content t(:yes, :scope => 'rsvp_describe_answer_for_you')


      page.must_have_button t(:say_no, :scope => 'activerecord.values.rsvp.answer')
      click_button t(:say_no, :scope => 'activerecord.values.rsvp.answer')
      page.must_have_content t(:no, :scope => 'rsvp_describe_answer_for_you')
    end

  end

end
