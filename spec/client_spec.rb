require 'spec_helper'
describe TSMS::Client do
  context "creating a new client" do
    before do
      response = double('response', :status=>200, :body => {"_links" => [{"self" => "/"}, {"horse" => "/horses/new"}, {"rabbits" => "/rabbits"}]})
      @raw_connection = double('raw_connection', :get => response)
      @connection = TSMS::Connection.stub(:new).and_return(double('connection', :connection => @raw_connection))
      @client = TSMS::Client.new('username', 'password', :api_root => 'null_url')
    end
    it 'should discover endpoints for known services' do
      @client.horse.should be_kind_of(TSMS::Horse)
      @client.rabbits.should be_kind_of(TSMS::Rabbits)
    end
    it 'should handle 4xx responses' do
      @raw_connection.stub(:get).and_return(double('response', :status => 404, :body => {'message' => 'hi'}))
      expect { @client.get('/blargh') }.to raise_error(TSMS::Request::Error)
    end
    it 'should handle 202 responses' do
      @raw_connection.stub(:get).and_return(double('response', :status => 202, :body => {'message' => 'hi'}))
      expect { @client.get('/blargh') }.to raise_error(TSMS::Request::InProgress)
    end
  end


end
