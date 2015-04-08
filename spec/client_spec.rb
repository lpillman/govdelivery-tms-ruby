require 'spec_helper'
describe TMS::Client do
  context "creating a new client" do
    before do
      response = double('response', status: 200, body: {"_links" => [{"self" => "/"}, {"horse" => "/horses/new"}, {"rabbits" => "/rabbits"}]})
      @raw_connection = double('raw_connection', get: response)
      @connection = allow(TMS::Connection).to receive(:new).and_return(double('connection', connection: @raw_connection))
      @client = TMS::Client.new('auth_token', api_root: 'null_url')
    end
    it 'should set up logging' do
      expect(@client.logger).not_to be_nil
      expect(@client.logger.level).to eq(Logger::INFO)
    end
    it 'should discover endpoints for known services' do
      expect(@client.horse).to be_kind_of(TMS::Horse)
      expect(@client.rabbits).to be_kind_of(TMS::Rabbits)
    end
    it 'should handle 4xx responses' do
      allow(@raw_connection).to receive(:get).and_return(double('response', status: 404, body: {'message' => 'hi'}))
      expect { @client.get('/blargh') }.to raise_error(TMS::Request::Error)
    end
    it 'should handle 5xx responses' do
      allow(@raw_connection).to receive(:get).and_return(double('response', status: 503, body: {'message' => 'oops'}))
      expect { @client.get('/blargh') }.to raise_error(TMS::Request::Error)
    end
    it 'should handle 202 responses' do
      allow(@raw_connection).to receive(:get).and_return(double('response', status: 202, body: {'message' => 'hi'}))
      expect { @client.get('/blargh') }.to raise_error(TMS::Request::InProgress)
    end

    context 'creating a new client without output' do
      subject { TMS::Client.new('auth_token', api_root: 'null_url', logger: false) }
      its(:logger){ should be_falsey }
      its(:horse) { should be_kind_of(TMS::Horse) }
    end

    it 'defaults to the public API URL' do
      expect(TMS::Client.new('auth_token').api_root).to eq('https://tms.govdelivery.com')
    end
  end
end
