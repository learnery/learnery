require "test_helper"

describe "omniauth integration test" do
  before do
    OmniAuth.config.test_mode = true
  end

  describe "handles callbacks from providers" do

    context "twitter" do
      before do
        OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
             :provider => 'twitter',
             :uid => '123545',
             :info => {:nickname => 'TheTwitterer' }
        })
      end

      it "logs in user with twitter" do
        visit root_path
        click_link t(:login_with, provider: :twitter)
        user = User.where(nickname: 'TheTwitterer').first
        page.must_have_content t(:logged_in_as, :user => user.user_info)
      end
    end

    context "github" do
      before do
        OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
             :provider => 'github',
             :uid => '123545',
             :info => {:nickname => 'TheTwitterer' }
        })
      end

      it "logs in user with github" do
        visit root_path
        click_link t(:login_with, provider: :twitter)
        user = User.where(nickname: 'TheTwitterer').first
        page.must_have_content t(:logged_in_as, :user => user.user_info)
      end
    end

  end
end
