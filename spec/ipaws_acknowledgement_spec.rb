require 'spec_helper'

describe TMS::IpawsAcknowledgement do

  it 'gets IPAWS acknowledgement from client' do
    client = double(:client)
    response_body = { "ACK" => "PONG" }
    ipaws_acknowledgement = TMS::IpawsAcknowledgement.new(client, '/ipaws/acknowledgement', {})
    expect(ipaws_acknowledgement.client).to receive('get').with(ipaws_acknowledgement.href).and_return(
      double('response', status: 200, body: response_body)
    )
    expect(ipaws_acknowledgement.get).to eq(ipaws_acknowledgement)
    expect(ipaws_acknowledgement.ACK).to eq("PONG")
  end

end
