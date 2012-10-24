# encoding: utf-8

module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      @user = User.new
      @user.email = "hoge@gmail.com"
      @user.password = "user0100"
      @user.password_confirmation = "user0100"
      @user.confirm!

      sign_in @user
    end
  end
end

