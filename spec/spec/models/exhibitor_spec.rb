# encoding: utf-8
require 'spec_helper'

describe Exhibitor do
  describe "validation" do
    let(:exhibitor) { FactoryGirl.build(:exhibitor) }
    subject { exhibitor }

    context "郵便番号が3桁の場合" do
      let(:exhibitor) { FactoryGirl.build(:exhibitor, :zip_code => 111) }

      it "バリデーションに失敗すること" do
        should_not be_valid
      end 
    end  

    context "郵便番号が5桁の場合" do
      let(:exhibitor) { FactoryGirl.build(:exhibitor, :zip_code => 11111) }
      it "バリデーションに成功すること" do
        should be_valid
      end 
    end

    context "郵便番号が7桁の場合" do
      it "バリデーションに成功すること" do
        should be_valid
      end 
    end

    context "郵便番号が8桁の場合" do
      let(:exhibitor) { FactoryGirl.build(:exhibitor, :zip_code => 11111111) }
      it "バリデーションに失敗すること" do
        should_not be_valid
      end 
    end
  end

  describe "noah_encrypt" do
    it "住所が暗号化されて保存されること" do
      exhibitor = FactoryGirl.build(:exhibitor) 
      address = exhibitor.address
      exhibitor.save
      exhibitor.reload
      exhibitor.address.should_not == address
    end    

    it "住所が復号化されること" do
      exhibitor = FactoryGirl.build(:exhibitor) 
      address = exhibitor.address
      exhibitor.save
      exhibitor.reload
      exhibitor.address_decrypt.should == address
    end

    context "バリデーションに失敗した場合" do
      it "住所が暗号化されていないこと" do
        exhibitor = Exhibitor.new :address => "hoge"
        exhibitor.should_not be_valid
        exhibitor.address.should == "hoge"
      end 
    end
  end

  describe "#select_bank_account_types" do
    before do
      @exhibitor = FactoryGirl.build(:exhibitor)
    end
    it "口座種別の一覧が返ること" do
      @exhibitor.select_bank_account_types == [ 
    ["普通預金",      "普通預金"], 
    ["総合口座",      "総合口座"], 
    ["当座預金",      "当座預金"],
    ["決済用普通預金","決済用普通預金"],
    ["貯蓄預金",      "貯蓄預金"],
    ["定期預金",      "定期預金"],
    ["積立預金",      "積立預金"],
    ["定期積金",      "定期積金"],
    ["通知預金",      "通知預金"],
    ["納税準備預金",  "納税準備預金"],
    ["別段預金",      "別段預金"] ]
    end 
  end
end
