# encoding: utf-8
require 'spec_helper'
require 'support/database_cleaner_context'

describe Video do
  describe "#create_video" do
    before do 
      @video = FactoryGirl.create(:video)
    end

    context "responseにerrorがない場合" do
      before do
        @video.stub(:request_create_video).and_return({"result" => 1234, "error" => nil})
      end

      it "brightcove_idが保存されること" do
        expect {
          @video.create_video
          @video.reload
        }.should change(@video, :brightcove_id).from(nil).to(1234)
      end
    end

    context "responseにerrorがある場合" do
      before do 
        @video.stub(:request_create_video).and_return({"result" => 1234, "error" => "201"})
      end

      it "brightcove_idが保存されないこと" do
        expect {
          @video.create_video
          @video.reload
        }.should_not change(@video, :brightcove_id)
        
      end
    end
  end

  describe "#request_create_video" do
    before(:all) do
      @video = FactoryGirl.create(:video)
    end

    include_context "database_cleaner"

    subject { @video.request_create_video }

    context "正しいパラメータを送った場合" do
      before do
        stub_request(:post, Video::BRIGHTCOVE_WRITE_URL).to_return(:body => {"result" => 1234, "error" => nil}.to_json)
      end

      it "Brightcoveへのアップロードが完了し、Hashが返ること" do
        should be_an_instance_of(Hash)
      end

      it "Brightcoveへのアップロードが完了し、errorがnilであること" do
        subject["error"].should be_nil
      end 

      it "Brightcoveへのアップロードが完了し、resultにvideo_idが含まれること" do
        subject["result"].should_not be_nil
      end
    end

    context "write_tokenが間違えていた場合" do
      before do
        response_body = {"error"=> {"name"=>"InvalidTokenError", "message"=>"invalid token", "code"=>210}, "result"=>nil, "id"=>nil}
        stub_request(:post, Video::BRIGHTCOVE_WRITE_URL).to_return(:body => response_body.to_json)
      end

      it "Brightcoveへのアップロードが失敗し、errorが含まれること" do
        subject["error"].should_not be_nil
      end 
    end
  end

  describe "#reference_id" do
    let(:video) { FactoryGirl.create(:video) }

    it "video_attachment.idが文字列に含まれること" do
      video.reference_id == "test_attachment_#{video.video_attachment.id}"  
    end
  end

  describe "#get_info" do
    let(:video) { FactoryGirl.create(:video) }

    before do
      params = {
        :command => "find_video_by_id",
        :token => Video::BRIGHTCOVE_READ_TOKEN,
      }
      query_string = params.map{|k,v| "#{k}=#{v}"}.join("&") + "&video_id"
      stub_request(:get, Video::BRIGHTCOVE_READ_URL + "?" + query_string).
        with(:headers => {'User-Agent'=>'brightcove-api gem 1.0.11'}).
        to_return(:status => 200, :body => {"videoStillURL" => "http://hoge.com"})
    end

    it "ハッシュが返ること" do
      video.get_info.should be_an_instance_of(Hash) 
    end

    it "videoStillURLをキーに持つこと" do
      video.get_info['videoStillURL'].should_not be_nil 
    end
  end

  describe "#upload_complete?" do
    let(:video) { FactoryGirl.create(:video) }
    subject { video.upload_complete? }

    before do
      stub_request(:post, Video::BRIGHTCOVE_WRITE_URL).to_return(:body => {"result" => result})
    end

    context "Brightcoveでアップロードが完了していた場合" do
      let(:result) { "COMPLETE" }
      it "trueになること" do
        should be_true
      end 
    end 

    context "Brightcoveでアップロードが完了していない場合" do
      let(:result) { "" }

      it "falseになること" do
        should be_false
      end 
    end
  end

  describe "#thumbnail" do
    subject { video.thumbnail }

    context "imageがある場合" do
      let(:video) { FactoryGirl.create(:video) }
      it "up_load3_s.gifが返ること" do
        should == "/images/registration/up_load3_s.gif" 
      end 
    end 

    context "imageが無い場合" do
      let(:video) { FactoryGirl.create(:video, :image => File.open(Rails.root.to_s + "/spec/support/images/nikujaga.jpg")) }
      it "thumnailが返ること" do
        should == video.image.size_236.url
      end
    end
  end

  describe ".get_info" do

    before do
      @video = FactoryGirl.create(:video)
      @video.stub(:upload_complete?).and_return(true)
      @video.stub(:get_info).and_return({"videoStillURL" => "http://www.abilie.com"})
      params = {
        :command => "find_video_by_id",
        :token => Video::BRIGHTCOVE_READ_TOKEN,
      }
      query_string = params.map{|k,v| "#{k}=#{v}"}.join("&") + "&video_id"
      stub_request(:get, Video::BRIGHTCOVE_READ_URL + "?" + query_string).
        with(:headers => {'User-Agent'=>'brightcove-api gem 1.0.11'}).
        to_return(:status => 200, :body => {"videoStillURL" => "http://hoge.com"})

      stub_request(:post, Video::BRIGHTCOVE_WRITE_URL).to_return(:body => {"result" => 1234, "error" => nil}.to_json)
      stub_request(:get, "http://www.abilie.com").to_return(:body => File.open(Rails.root.to_s + "/spec/support/images/nikujaga.jpg"))
    end

    it "video.imageが保存されていること" do
      Video.get_info 
      @video.reload
      @video.image.should_not be_nil
    end
  end

  describe ".queue" do
    it ":abilieが返ること" do
      Video.queue.should == :abilie 
    end 
  end
end
