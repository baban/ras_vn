# -*- coding: utf-8 -*-
require 'spec_helper'

describe Services::Facebook do
  describe ".get_original_image" do
    it "画像のurlの\"type=square\"が\"type=large\"に置換されてimageに登録されること" do
      Services::Facebook.get_original_image("hoge.png?type=square").should == "hoge.png?type=large"
    end
  end
end
