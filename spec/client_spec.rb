require 'spec_helper'
describe TMS::Client do
  context "creating a new client" do
    before do
      response = double('response', :status=>200, :body => {"_links" => [{"self" => "/"}, {"horse" => "/horses/new"}, {"rabbits" => "/rabbits"}]})
      @raw_connection = double('raw_connection', :get => response)
      @connection = TMS::Connection.stub(:new).and_return(double('connection', :connection => @raw_connection))
      @client = TMS::Client.new('username', 'password', :api_root => 'null_url')
    end
    it 'should discover endpoints for known services' do
      @client.horse.should be_kind_of(TMS::Horse)
      @client.rabbits.should be_kind_of(TMS::Rabbits)
    end
    it 'should handle 4xx responses' do
      @raw_connection.stub(:get).and_return(double('response', :status => 404, :body => {'message' => 'hi'}))
      expect { @client.get('/blargh') }.to raise_error(TMS::Request::Error)
    end
    it 'should handle 202 responses' do
      @raw_connection.stub(:get).and_return(double('response', :status => 202, :body => {'message' => 'hi'}))
      expect { @client.get('/blargh') }.to raise_error(TMS::Request::InProgress)
    end
  end


end
