require 'spec_helper'

describe GovDelivery::TMS::IpawsEventCodes do
  context "loading Ipaws event codes" do
    let(:client) { double('client') }
    let(:event_codes) { GovDelivery::TMS::IpawsEventCodes.new(client, '/ipaws/event_codes') }
    it 'should GET itself' do
      body = [
        {
          value: 'ADR',
          description: 'Administrative Message/Follow up Statement',
          cap_exchange: true,
          core_ipaws_profile: true,
          nwem: true,
          eas_and_public: true,
          cmas: true
        },
        {
          value: 'AVA',
          description: 'Avalanche Watch',
          cap_exchange: true,
          core_ipaws_profile: true,
          nwem: true,
          eas_and_public: true,
          cmas: false        }
      ]
      expect(client).to receive(:get).and_return(double('response', body: body, status: 200, headers: {}))
      event_codes.get
      expect(event_codes.collection.length).to eq(2)
      event_codes.collection.each do |event_code|
        expect(event_code).to be_an_instance_of(GovDelivery::TMS::IpawsEventCode)
      end
    end
  end
end
