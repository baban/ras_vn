# encoding: utf-8
shared_context "ログインする" do
  let(:user) { FactoryGirl.create(:user) }
  before do
    controller.stub(:current_user).and_return(user)
  end
end

shared_examples_for "require_login" do
  it "ログイン画面にリダイレクトされること" do
    response.should redirect_to signin_path
  end 
end
