require "test_helper"

describe "omniauth integration test" do
  before do
    puts "****************************"
    puts self.class
    OmniAuth.config.test_mode = true
 #   request.env["devise.mapping"] = Devise.mappings[:user]
 #   request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
  end
#  it "logs in user with twitter" do
#    visit root_path
#    click_link t(:sign_up_with, :provider => :twitter)
#    page.must_have_content t(:logged_in_as, :user => user.email)
#  end

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
  end
end
