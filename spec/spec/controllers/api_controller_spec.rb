# encoding: utf-8
require 'spec_helper'

describe ApiController do
  describe "POST convert" do
    render_views
    it "Abilie記法で書かれたテキストをHTMLに変換されること" do
      get :convert, :text => "hogehoge", :format => "json"
      response.body.should == {:body => "<p>hogehoge</p>\n"}.to_json   
    end
  end
end
