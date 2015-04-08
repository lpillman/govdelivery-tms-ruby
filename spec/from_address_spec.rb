require 'spec_helper'

describe TMS::FromAddress do
  context "creating a list of from addresses" do
    let(:client) do
      double('client')
    end
    before do
      @fromaddresses = TMS::FromAddress.new(client, '/from_addresses')
    end

    it 'should be able to get a list of email templates' do
      response = [{
           'from_email'      => "something@evotest.govdelivery.com",
           'reply_to_email'  => "something@evotest.govdelivery.com",
           'bounce_email'    => "something@evotest.govdelivery.com",
           'is_default'      => true,
           'created_at'      => "sometime",
           '_links'          => {"self" => "/from_addresses/1"}
      }]

      expect(@fromaddresses.client).to receive('get').with('/from_addresses').and_return(double('/from_addresses', status: 200, body: @from_addresses))
      @fromaddresses.get
      expect(@fromaddresses).to eq(@fromaddresses)
    end
  end

  context "creating a from address" do
    let(:client) do
      double('client')
    end

    before do
      @fromaddress = TMS::FromAddress.new(client, '/from_addresses', {
           from_email:      "something@evotest.govdelivery.com",
           reply_to_email:  "something@evotest.govdelivery.com",
           bounce_email:    "something@evotest.govdelivery.com",
           is_default:      true})
    end

    it 'should post successfully' do
      response = {
           'from_email'      => "something@evotest.govdelivery.com",
           'reply_to_email'  => "something@evotest.govdelivery.com",
           'bounce_email'    => "something@evotest.govdelivery.com",
           'is_default'      => true,
           'created_at'      => "sometime",
           '_links'          => {"self" => "/from_addresses/1"}
      }
      expect(@fromaddress.client).to receive('post').with(@fromaddress).and_return(double('response', status: 201, body: response ))
      @fromaddress.post
      expect(@fromaddress.from_email).to                   eq("something@evotest.govdelivery.com")
      expect(@fromaddress.reply_to_email).to               eq("something@evotest.govdelivery.com")
      expect(@fromaddress.bounce_email).to                 eq("something@evotest.govdelivery.com")
      expect(@fromaddress.is_default).to                   eq(true)
      expect(@fromaddress.created_at).to                   eq("sometime")
      expect(@fromaddress.href).to                         eq("/from_addresses/1")
    end
  end

  context "handling errors" do
    let(:client) do
      double('client')
    end
    before do
      @fromaddress = TMS::FromAddress.new(client, '/from_addresses/1')
    end

    it 'should handle errors' do
      response = {'errors' => {from_email: "can't be nil"}}
      expect(@fromaddress.client).to receive('post').with(@fromaddress).and_return(double('response', status: 422, body: response))
      @fromaddress.post
      expect(@fromaddress.errors).to eq({from_email: "can't be nil"})
    end

    it 'should handle 401 errors' do
      expect(@fromaddress.client).to receive('post').with(@fromaddress).and_return(double('response', status: 401))
      expect {@fromaddress.post}.to raise_error("401 Not Authorized")
    end

    it 'should handle 404 errors' do
      expect(@fromaddress.client).to receive('post').with(@fromaddress).and_return(double('response', status: 404))
      expect {@fromaddress.post}.to raise_error("Can't POST to /from_addresses/1")
    end
  end
end