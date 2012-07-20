# encoding: utf-8
require 'spec_helper'

describe TicketsHelper do
  describe "#ticket_publishable?" do
    subject { helper.ticket_publishable?(ticket) }

    context "チケットがアビリティであれば" do
      let(:ticket) { FactoryGirl.create(:ticket) }
      it "trueになること" do
        should be_true 
      end
    end 

    context "チケットがアビリティでなく" do
      context "動画で" do
        let(:ticket) { FactoryGirl.create(:video_ticket) }
        context "動画が存在すれば" do
          before do
            FactoryGirl.create(:video, :ticket => ticket)
          end

          it "trueになること" do
            should be_true
          end
        end

        context "動画が無い場合" do
          it "falseになること" do
            should be_false
          end
        end
      end

      context "PDFで" do
        let(:ticket) { FactoryGirl.create(:pdf_ticket) }
        context "PDFが存在すれば" do
          before do
            FactoryGirl.create(:pdf, :ticket => ticket)
          end

          it "trueになること" do
            should be_true
          end
        end

        context "PDFがなければ" do
          it "falseになること" do
            should be_false
          end
        end
      end
    end
  end
  
  describe "#purchase_range" do
    let(:count) { 0 } 
    let(:figure) { 10 } 
    subject { helper.purchase_range(count, figure) }
    
    context "購入者数が0の時" do
      it "0になること" do
        should == 0  
      end
    end 
    context "桁指定初期値が10の時" do
      context "購入者数が1の時" do
        let(:count) { 1 } 
        it "1-10になること" do
          should == "1-10"  
        end
      end
      context "購入者数が11の時" do
        let(:count) { 11 } 
        it "11-20になること" do
          should == "11-20"  
        end
      end 
      context "購入者数が100の時" do
        let(:count) { 100 } 
        it "91-100になること" do
          should == "91-100"  
        end
      end 
      context "購入者数が101の時" do
        let(:count) { 101 } 
        it "101-200になること" do
          should == "101-200"  
        end
      end 
    end

    context "桁指定初期値が50の時" do
      let(:figure) { 50 } 
      context "購入者数が1の時" do
        let(:count) { 1 } 
        it "1-50になること" do
          should == "1-50"  
        end
      end
      context "購入者数が51の時" do
        let(:count) { 51 } 
        it "51-100になること" do
          should == "51-100"  
        end
      end 
      context "購入者数が500の時" do
        let(:count) { 500 } 
        it "451-500になること" do
          should == "451-500"  
        end
      end 
      context "購入者数が501の時" do
        let(:count) { 501 } 
        it "501-1000になること" do
          should == "501-1000"  
        end
      end 
    end
  end
end
