require 'spec_helper'
require 'mail'
require 'govdelivery-tms/mail/delivery_method'
describe TMS::Mail::DeliveryMethod do
  subject { TMS::Mail::DeliveryMethod.new({}) }
  let(:client) { double('TMS::Client') }
  let(:email_messages) { double('email_messages') }
  let(:tms_message) { double('tms_message', :recipients => double(:build => TMS::Recipient.new('href'))) }

  it 'should work with a basic Mail::Message' do
    mail = Mail.new do
      subject 'hi'
      from '"My mom" <my@mom.com>'
      to '"A Nice Fellow" <tyler@sink.govdelivery.com>'
      body '<blink>HI</blink>'
    end
    client.stub(:email_messages).and_return(email_messages)
    subject.stub(:client).and_return(client)
    email_messages.should_receive(:build).with(
        :from_name => mail[:from].display_names.first,
        :subject   => mail.subject,
        :body      => '<blink>HI</blink>'
      ).and_return(tms_message)
    tms_message.should_receive(:post!).and_return(true)

    subject.deliver!(mail)
  end

  it 'should work with a multipart Mail::Message' do
    mail = Mail.new do
      subject 'hi'
      from '"My mom" <my@mom.com>'
      to '"A Nice Fellow" <tyler@sink.govdelivery.com>'

      html_part do
        content_type 'text/html; charset=UTF-8'
        body '<blink>HTML</blink>'
      end
    end
    client.stub(:email_messages).and_return(email_messages)
    subject.stub(:client).and_return(client)
    email_messages.should_receive(:build).with(
        :from_name => mail[:from].display_names.first,
        :subject   => mail.subject,
        :body      => '<blink>HTML</blink>'
      ).and_return(tms_message)
    tms_message.should_receive(:post!).and_return(true)

    subject.deliver!(mail)
  end

end
