require 'spec_helper'

describe TSMS::CommandTypes do
  context "loading command types" do
    let(:client) do
      double('client')
    end
    before do
      @command_types = TSMS::CommandTypes.new(client, '/command_types')
    end
    it 'should GET ok' do
      body = [{"fields"=>["dcm_account_codes"], "name"=>"dcm_unsubscribe"}, 
              {"fields"=>["dcm_account_code", "dcm_topic_codes"], "name"=>"dcm_subscribe"}, 
              {"fields"=>["http_method", "username", "password", "url"], "name"=>"forward"}] 
      @command_types.client.should_receive(:get).and_return(double('response', :body => body, :status => 200, :headers => {}))
      @command_types.get
      @command_types.collection.length.should == 3
    end
  end
end