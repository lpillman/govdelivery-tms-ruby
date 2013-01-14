require 'spec_helper'

describe TSMS::SmsMessage do
  context "creating a new message" do
    let(:client) do
      double('client')
    end
    before do
      @message = TSMS::SmsMessage.new(client, nil, {:body => '12345678', :created_at => 'BAAAAAD'})
    end
    it 'should not render readonly attrs in json hash' do
      @message.to_json[:body].should == '12345678'
      @message.to_json[:created_at].should == nil
    end
    it 'should initialize with attrs and collections' do
      @message.body.should == '12345678'
      @message.recipients.class.should == TSMS::Recipients
    end
    it 'should post successfully' do
      response = {:body => 'processed', :recipients => [{:phone => '22345678'}], :created_at => 'time'}
      @message.client.should_receive('post').with(@message).and_return(double('response', :status => 201, :body => response))
      @message.post
      @message.body.should == 'processed'
      @message.created_at.should == 'time'
      @message.recipients.class.should == TSMS::Recipients
      @message.recipients.collection.first.class.should == TSMS::Recipient
    end
    it 'should handle errors' do
      response = {'errors' => {:body => "can't be nil"}}
      @message.client.should_receive('post').with(@message).and_return(double('response', :status => 422, :body => response))
      @message.post
      @message.body.should == '12345678'
      @message.errors.should == {:body => "can't be nil"}
    end
  end

  context 'an existing message' do
    let(:client) do
      double('client')
    end
    before do
      # blank hash prevents the client from doing a GET in the initialize method
      @message = TSMS::SmsMessage.new(client, '/messages/99', {})
    end
    it 'should GET cleanly' do
      response = {:body => 'processed', :recipients => [{:phone => '22345678'}], :created_at => 'time'}
      @message.client.should_receive('get').with(@message.href).and_return(double('response', :status => 200, :body => response))
      @message.get
      @message.body.should == 'processed'
      @message.created_at.should == 'time'
    end
  end


end
