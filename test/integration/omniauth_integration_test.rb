require "test_helper"

describe "omniauth integration test" do
  before do
    OmniAuth.config.test_mode = true
  end

  describe "handles callbacks from providers" do
    Learnery::Application.config.oauth_providers.each do | oauth_provider |
      context oauth_provider.to_s do
        before do
          OmniAuth.config.mock_auth[oauth_provider] = OmniAuth::AuthHash.new({
               :provider => oauth_provider,
               :uid => '123545',
               :info => {:nickname => 'TheNickName' }
          })
        end

        it "logs in user with twitter" do
          visit root_path
          click_link t(:login_with, provider: oauth_provider)
          user = User.where(nickname: 'TheNickName').first
          page.must_have_content t(:logged_in_as, :user => user.user_info)
        end
      end
    end
  end
end
