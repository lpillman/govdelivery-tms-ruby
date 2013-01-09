require 'spec_helper'

describe TSMS::ActionTypes do
  context "loading action types" do
    let(:client) do
      double('client')
    end
    before do
      @action_types = TSMS::ActionTypes.new(client, '/action_types')
    end
    it 'should GET ok' do
      body = [{"fields"=>["dcm_account_codes"], "name"=>"dcm_unsubscribe"}, 
              {"fields"=>["dcm_account_code", "dcm_topic_codes"], "name"=>"dcm_subscribe"}, 
              {"fields"=>["http_method", "username", "password", "url"], "name"=>"forward"}] 
      @action_types.client.should_receive(:get).and_return(double('response', :body => body, :status => 200, :headers => {}))
      @action_types.get
      @action_types.collection.length.should == 3
    end
  end
end