require 'spec_helper'

describe TMS::EmailMessage do
  context "creating a new message" do
    let(:client) do
      double('client')
    end
    before do
      @message = TMS::EmailMessage.new(client, '/messages/email', {
        :body       => '12345678',
        :subject    => 'blah',
        :created_at => 'BAAAAAD',
        :from_email => 'eric@evotest.govdelivery.com',
        :errors_to  => 'errors@evotest.govdelivery.com',
        :reply_to   => 'replyto@evotest.govdelivery.com'})
    end
    it 'should not render readonly attrs in json hash' do
      @message.to_json[:body].should == '12345678'
      @message.to_json[:created_at].should == nil
    end
    it 'should initialize with attrs and collections' do
      @message.body.should             == '12345678'
      @message.subject.should          == 'blah'
      @message.from_email.should       == 'eric@evotest.govdelivery.com'
      @message.reply_to.should         == 'replyto@evotest.govdelivery.com'
      @message.errors_to.should        == 'errors@evotest.govdelivery.com'
      @message.recipients.class.should == TMS::EmailRecipients
    end
    it 'should post successfully' do
      response = {
          :body       => 'processed',
          :subject    => 'blah',
          :from_email => 'eric@evotest.govdelivery.com',
          :errors_to  => 'errors@evotest.govdelivery.com',
          :reply_to   => 'replyto@evotest.govdelivery.com',
          :recipients => [{:email => 'billy@evotest.govdelivery.com'}],
          :failed => [{:email => 'billy@evotest.govdelivery.com'}],
          :sent => [{:email => 'billy@evotest.govdelivery.com'}],
          :created_at => 'time'
      }
      @message.client.should_receive('post').with(@message).and_return(double('response', :status => 201, :body => response))
      @message.post
      @message.body.should                              == 'processed'
      @message.created_at.should                        == 'time'
      @message.from_email.should                        == 'eric@evotest.govdelivery.com'
      @message.reply_to.should                          == 'replyto@evotest.govdelivery.com'
      @message.errors_to.should                         == 'errors@evotest.govdelivery.com'
      @message.recipients.class.should                  == TMS::EmailRecipients
      @message.recipients.collection.first.class.should == TMS::EmailRecipient
      @message.sent.class.should == TMS::EmailRecipients
      @message.sent.collection.first.class.should == TMS::EmailRecipient
      @message.failed.class.should == TMS::EmailRecipients
      @message.failed.collection.first.class.should == TMS::EmailRecipient
    end
    it 'should handle errors' do
      response = {'errors' => {:body => "can't be nil"}}
      @message.client.should_receive('post').with(@message).and_return(double('response', :status => 422, :body => response))
      @message.post
      @message.body.should == '12345678'
      @message.errors.should == {:body => "can't be nil"}
    end

    it 'should handle 401 errors' do
      @message.client.should_receive('post').with(@message).and_return(double('response', :status => 401))
      expect {@message.post}.to raise_error(StandardError, "401 Not Authorized")
    end

    it 'should handle 404 errors' do
      @message.client.should_receive('post').with(@message).and_return(double('response', :status => 404))
      expect {@message.post}.to raise_error(StandardError, "Can't POST to /messages/email")
    end
  end

  context 'an existing message' do
    let(:client) do
      double('client')
    end
    before do
      # blank hash prevents the client from doing a GET in the initialize method
      @message = TMS::EmailMessage.new(client, '/messages/99', {})
    end
    it 'should GET cleanly' do
      response = {:body => 'processed',
                  :subject    => 'hey',
                  :from_email => 'eric@evotest.govdelivery.com',
                  :errors_to  => 'errors@evotest.govdelivery.com',
                  :reply_to   => 'replyto@evotest.govdelivery.com',
                  :recipients => [{:email => 'billy@evotest.govdelivery.com'}],
                  :created_at => 'time'}
      @message.client.should_receive('get').with(@message.href).and_return(double('response', :status => 200, :body => response))
      @message.get
      @message.body.should       == 'processed'
      @message.subject.should    == 'hey'
      @message.from_email.should == 'eric@evotest.govdelivery.com'
      @message.reply_to.should   == 'replyto@evotest.govdelivery.com'
      @message.errors_to.should  == 'errors@evotest.govdelivery.com'
      @message.created_at.should == 'time'
    end
  end


end
