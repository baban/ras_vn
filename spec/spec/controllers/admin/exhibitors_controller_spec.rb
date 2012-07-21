# encoding: utf-8
require 'spec_helper'

describe Admin::ExhibitorsController do
  describe "PUT adopt" do
    let(:user) { FactoryGirl.create(:user) }
    let(:exhibitor) { FactoryGirl.create(:exhibitor, :user => user) }

    before do
      controller.stub(:current_user).and_return(FactoryGirl.create(:admin_user))
      put :adopt, :id => exhibitor.id 
      user.reload
    end

    it "userのexhibitor_flagがtrueになること" do
      user.exhibitor_flag.should == true
    end

    it "exhibitorのadopted_atに時間が入ること" do
      user.exhibitor.adopted_at.should_not be_nil
    end
  end
end
