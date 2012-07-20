# encoding: utf-8

require 'spec_helper'

describe TopController do
  fixtures :all
  context "非ログイン時" do
    describe "GET 'index'" do
      it "returns http success" do
        get :index
        response.should be_success
      end
    end
  end
end
