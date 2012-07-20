# encoding: utf-8
shared_context "capybara_login" do
  let(:user) { FactoryGirl.create(:exhibited_user) }
  before(:all) do
    OmniAuth.config.test_mode = true
  end

  after(:all) do
    OmniAuth.config.test_mode = false
  end
 
  before do
    OmniAuth.config.mock_auth[:facebook] = { 
      "uid" => user.services.first.uid,
      "provider" => "facebook",
      "credentials" => { "token" => "hogehoge" }
    }
    visit signin_path

    click_link "facebook-login-button"
  end
end
