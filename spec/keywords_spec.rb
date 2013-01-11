require 'spec_helper'

describe TSMS::Keywords do
  context "loading keywords" do
    let(:client) do
      double('client')
    end
    before do
      @keywords = TSMS::Keywords.new(client, '/keywords')
    end
    it 'should GET ok' do
      body = [
        {"name"=>"services", "_links"=>{"self"=>"/keywords/1"}}, 
        {"name"=>"subscribe", "_links"=>{"self"=>"/keywords/2"}}
      ]
      @keywords.client.should_receive(:get).and_return(double('response', :body => body, :status => 200, :headers => {}))
      @keywords.get
      @keywords.collection.length.should == 2
    end
  end
end