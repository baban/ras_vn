# -*- coding: utf-8 -*-
require 'spec_helper'
require 'support/database_cleaner_context'

describe CategoriesController do

  describe "GET 'show'" do
    before(:all) do
      @category = FactoryGirl.create(:category)
      13.times do
        FactoryGirl.create(:opening_ticket,:category => @category)
      end
    end
    include_context "database_cleaner"
    
    context "カテゴリ詳細ページにアクセスした場合" do
      before do
        get :show, :id => @category.url_name
      end
      it 'show のテンプレートが読まれること' do
        response.should render_template('show')
      end
      it "@ticketsが12件あること(チャンクは12件)" do
        assigns[:tickets].should have(12).items 
      end
    end
    context "カテゴリ詳細ページの２ページ目にアクセスした場合" do
      before do
        get :show, :id => @category.url_name, :page => 2
      end
      it 'show のテンプレートが読まれること' do
        response.should render_template('show')
      end
      it "@ticketsが1件あること(チャンクは12件。データは13件)" do
        assigns[:tickets].should have(1).items 
      end
    end
    context "存在しないカテゴリ詳細ページにアクセスした場合" do
    it "404になること" do
        lambda {
          get :show, :id => "not_found" 
        }.should raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "GET popular" do
    before(:all) do
      @category = FactoryGirl.create(:category)

      13.times do
        FactoryGirl.create(:opening_ticket,:category => @category)
      end
    end

    include_context "database_cleaner"

    context "カテゴリ詳細ページにアクセスした場合" do
      before do
        get :popular, :id => @category.url_name
      end

      it 'show のテンプレートが読まれること' do
        response.should render_template('show')
      end

      it "@ticketsが12件あること(チャンクは12件)" do
        assigns[:tickets].should have(12).items 
      end
    end

    context "存在しないカテゴリ詳細ページにアクセスした場合" do
      it "404になること" do
        lambda {
          get :popular, :id => "not_found" 
        }.should raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
