# encoding: utf-8
require 'spec_helper'

describe ApplicationController do
  describe "#current_user" do
    subject { controller.send(:current_user) }

    context "session[:user_id]があり" do
      context "session[:user_id]がDBにあれば" do
        before do
          session[:user_id] = FactoryGirl.create(:user).id
        end

        it "Userのインスタンスが返ること" do
          should be_an_instance_of User 
        end
      end

      context "session[:user_id]がDBになければ" do
        before do
          session[:user_id] = "hoge"
        end
        it "nilが返ること" do
          should be_nil  
        end
      end
    end  

    context "session[:user_id]がなければ" do
      before do
        session[:user_id] = nil
      end

      it "nilが返ること" do
        should be_nil  
      end      
    end
  end

  describe "#signed_in?" do
    subject { controller.send(:signed_in?) }

    context "current_userがnilなら" do
      before do
        controller.stub(:current_user).and_return(nil)
      end

      it "falseになること" do
        should be_false    
      end
    end

    context "current_userがあれば" do
      before do
        controller.stub(:current_user).and_return(FactoryGirl.create(:user))
      end

      it "trueになること" do
        should be_true
      end
    end
  end

  describe "categories" do
    before do
      8.times do
        FactoryGirl.create(:category)
      end
    end
    
    it "カテゴリが8件返ること" do
      controller.send(:categories).should have(8).items
    end
  end

  describe "#public_timeline" do
    before do
      ticket = FactoryGirl.create(:opening_ticket)
      FactoryGirl.create(:review, :ticket => ticket)
      FactoryGirl.create(:note)
    end

    it "アクティビティが3件返ること" do
      controller.send(:public_timeline).should have(3).items 
    end
  end

  describe "#replyable?" do
    let(:user) { build(:user) }
    let(:current_user) { build(:user) }

    subject { controller.send(:replyable?, user) }

    context "ユーザーのボード投稿拒否フラグがtrueの場合" do
      let(:user) { build(:refuse_board_user) }
      it { should be_false }
    end

    context "ユーザーのボード投稿拒否フラグがfalseで" do
      context "ログインしていない場合" do
        before do
          controller.stub(:signed_in?).and_return(false)
        end
        
        it { should be_false }
      end

      context "ログインしていて" do
        context "ログインしているユーザーと指定したユーザーが同じ場合" do
          let(:current_user) { user }
          before do
            controller.stub(:signed_in?).and_return(true)
            controller.stub(:current_user).and_return(current_user)
          end

          it { should be_false }
        end

        context "ログインしているユーザーと指定したユーザーが異なる場合" do
          let(:user) { create(:user) }
          let(:current_user) { create(:user) }

          before do
            controller.stub(:signed_in?).and_return(true)
            controller.stub(:current_user).and_return(current_user)
          end

          it { should be_true }
        end
      end
    end
  end
end
