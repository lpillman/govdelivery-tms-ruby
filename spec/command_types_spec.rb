require 'spec_helper'

describe TMS::CommandTypes do
  context "loading command types" do
    let(:client) do
      double('client')
    end
    before do
      @command_types = TMS::CommandTypes.new(client, '/command_types')
    end
    it 'should GET ok' do
      body = [{"name"=>"dcm_unsubscribe",
               "string_fields"=>[],
               "array_fields"=>["dcm_account_codes"]},
              {"name"=>"dcm_subscribe",
               "string_fields"=>["dcm_account_code"],
               "array_fields"=>["dcm_topic_codes"]},
              {"name"=>"forward",
               "string_fields"=>["http_method", "username", "password", "url"],
               "array_fields"=>[]}] 
      @command_types.client.should_receive(:get).and_return(double('response', :body => body, :status => 200, :headers => {}))
      @command_types.get
      @command_types.collection.length.should == 3
      ct = @command_types.collection.find{|c| c.name == "dcm_subscribe"}
      ct.array_fields.should eq(["dcm_topic_codes"])
      ct.string_fields.should eq(["dcm_account_code"])
    end
  end
end