# encoding: utf-8
require 'spec_helper'

describe Sbps::Request do
  describe ".request" do
    let(:success_xml) {
      <<-EOS
      <?xml version='1.0' encoding='Shift_JIS' ?>
      <sps-api-response id="ST01-00101-101">
        <res_result>OK</res_result>
      </sps-api-response>
      EOS
    }

    subject { Sbps::Request.request("xml") }
    before do
      stub_request(:post, "https://#{Sbps::Config.basic_auth_id}:#{Sbps::Config.basic_auth_pass}@stbfep.sps-system.com/api/xmlapi.do").
        with(:body => "xml", :headers => {"Accept" => "*/*", "Content-Type" => "text/xml; charset=Shift_JIS", "User-Agent" => "Ruby"}).
        to_return(:status => 200, :body => success_xml)
    end

    it "responseが返ること" do
      should be_an_instance_of Sbps::Response
    end
  end

  describe ".connection" do
    subject { Sbps::Request.send(:connection) }

    it "Faraday::Connectionが返ること" do
      should be_an_instance_of Faraday::Connection
    end

    it "connectionのhostにstbfep.sps-system.comがセットされていること" do
      subject.host == "stbfep.sps-system.com"
    end
  end
end
