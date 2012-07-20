# encoding: utf-8
require 'spec_helper'

shared_context "build_sbps_response" do
  let(:xml) {
    <<-EOS
    <?xml version='1.0' encoding='Shift_JIS' ?>
    <sps-api-response id="ST01-00101-101">
      <res_result>OK</res_result>
    </sps-api-response>
    EOS
  }

  before do
    @faraday_response = mock(Faraday::Response)
    @faraday_response.stub!(:body).and_return(xml)
    @response = Sbps::Response.new @faraday_response
  end

end

describe Sbps::Response do
  describe "#initialize" do
    include_context "build_sbps_response" 

    it "bodyにhashがセットされていること" do
      @response.body.should be_an_instance_of Hash 
    end

    it "faradayに@faraday_responseがセットされていること" do
      @response.faraday.should == @faraday_response  
    end
    
  end

  describe "#error?" do
    include_context "build_sbps_response" 
    context "OKなリクエストの場合" do
      it "errorでないこと" do
        @response.error?.should be_false
      end
    end

    context "NGなリクエストの場合" do
      let(:xml) {
        <<-EOS
        <?xml version='1.0' encoding='Shift_JIS' ?>
        <sps-api-response id="ST01-00101-101">
          <res_result>NG</res_result>
        </sps-api-response>
        EOS
      }

      it "errorであること" do
        @response.error?.should be_true
      end
    end

  end


  describe "#error" do
    include_context "build_sbps_response" 

    context "OKなリクエストの場合" do
      it "nilであること" do
        @response.error.should be_nil
      end
    end

    context "NGなリクエストの場合" do
      let(:xml) {
        <<-EOS
        <?xml version='1.0' encoding='Shift_JIS' ?>
        <sps-api-response id="ST01-00101-101">
          <res_result>NG</res_result>
          <res_err_code>111</res_err_code>
        </sps-api-response>
        EOS
      }

      it "errorを返すこと" do
        @response.error.should == "111"
      end
    end
    
  end

  describe "#to_s" do
    include_context "build_sbps_response" 
    
    it "xmlを返すこと" do
      @response.to_s == xml
    end
  end
end
