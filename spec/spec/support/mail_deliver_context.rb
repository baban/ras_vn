# encoding: utf-8
shared_context "mock_mailer" do
  let(:mail) do
    mail = mock(Mail::Message)
    mail.stub(:deliver).and_return(true)
    mail
  end
end
