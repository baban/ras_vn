# -*- coding: utf-8 -*-
require 'spec_helper'
require 'carrierwave/test/matchers'

describe Attachment do
  include CarrierWave::Test::Matchers

  before do
    AttachmentUploader.enable_processing = true
    @attachment = FactoryGirl.create(:attachment)
  end

  after do
    AttachmentUploader.enable_processing = false
  end


  describe "#to_markdown" do
    it "markdown 記法で画像形式の記法が返って来ること" do
      @attachment.to_markdown.should == "![画像](#{@attachment.image.size_550.url} \"#{@attachment.image_identifier}\")"
    end
  end

  describe "#for_img_tag" do
    it "imgタグを作る為に必要なデータが返されること" do
      @attachment.for_img_tag.should == {:image => @attachment.image.size_550.url, :markdown => @attachment.to_markdown}
    end
  end
end
