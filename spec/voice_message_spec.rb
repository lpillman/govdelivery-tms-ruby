require 'spec_helper'

describe TMS::VoiceMessage do
  context "creating a new message" do
    let(:client) do
      double('client')
    end
    before do
      @message = TMS::VoiceMessage.new(client, nil, {:play_url => 'http://what.cd'})
    end
    it 'should not render readonly attrs in json hash' do
      @message.to_json[:play_url].should == 'http://what.cd'
      @message.to_json[:created_at].should == nil
    end
    it 'should initialize with attrs and collections' do
      @message.play_url.should == 'http://what.cd'
      @message.recipients.class.should == TMS::Recipients
    end
    it 'should post successfully' do
      response = { :body => 'processed',
                   :recipients => [{:phone => '22345678'}],
                   :failed => [{:phone => '22345678'}],
                   :sent => [{:phone => '22345678'}],
                   :created_at => 'time'}
      @message.client.should_receive('post').with(@message).and_return(double('response', :status => 201, :body => response))
      @message.post
      # @message.body.should == 'processed'
      @message.created_at.should == 'time'
      @message.recipients.class.should == TMS::Recipients
      @message.recipients.collection.first.class.should == TMS::Recipient
      @message.sent.class.should == TMS::Recipients
      @message.sent.collection.first.class.should == TMS::Recipient
      @message.failed.class.should == TMS::Recipients
      @message.failed.collection.first.class.should == TMS::Recipient
    end
    it 'should handle errors' do
      response = {'errors' => {:play_url => "can't be nil"}}
      @message.client.should_receive('post').with(@message).and_return(double('response', :status => 422, :body => response))
      @message.post
      # @message.body.should == '12345678'
      @message.errors.should == {:play_url => "can't be nil"}
    end
  end

  context 'an existing message' do
    let(:client) do
      double('client')
    end
    before do
      # blank hash prevents the client from doing a GET in the initialize method
      @message = TMS::VoiceMessage.new(client, '/messages/99', {})
    end
    it 'should GET cleanly' do
      response = {:play_url => 'processed', :recipients => [{:phone => '22345678'}], :created_at => 'time'}
      @message.client.should_receive('get').with(@message.href).and_return(double('response', :status => 200, :body => response))
      @message.get
      @message.play_url.should == 'processed'
      @message.created_at.should == 'time'
    end
  end


end
