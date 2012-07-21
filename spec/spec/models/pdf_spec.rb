# -*- coding: utf-8 -*-
require 'spec_helper'

describe Pdf do
  let(:pdf) { Pdf.new }

  describe "#drm_file" do
    context "fileが存在しない場合" do
      it "falseになること" do
        pdf.drm_file.should be_false 
      end
    end

    context "fileが存在する場合" do
      it "krpdfファイルが作成されること" do
        pending "bookendェ(書けない)"        
      end
    end
  end

  describe "#drm_sample_file" do
    context "sample_fileが存在しない場合" do
      it "falseになること" do
        pdf.drm_sample_file.should be_false 
      end
    end

    context "sample_fileが存在する場合" do
      it "krpdfファイルが作成されること" do
        pending "bookendェ(書けない)"        
      end
    end
  end

  describe "#upload_file" do
    context "fileが存在しない場合" do
      it "falseになること" do
        pdf.upload_file.should be_false 
      end
    end

    context "fileが存在する場合" do
      it "krpdfファイルが作成されること" do
        pending "bookendェ(書けない)"        
      end
    end
    
  end

  describe "#upload_sample_file" do
    context "fileが存在しない場合" do
      it "falseになること" do
        pdf.upload_sample_file.should be_false 
      end
    end

    context "fileが存在する場合" do
      it "krpdfファイルが作成されること" do
        pending "bookendェ(書けない)"        
      end
    end
  end
end
