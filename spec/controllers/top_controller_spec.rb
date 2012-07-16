# encoding: utf-8

require 'spec_helper'

describe TopController do

  describe "GET 'index'" do
    before do
      session["session_id"]="21b06649224817f12cad479a53eacb36"
    end
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

end
