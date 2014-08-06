require 'spec_helper'

describe TMS::IpawsAcknowledgement do

  it 'gets IPAWS acknowledgement from client' do
    client = double(:client)
    response_body = { "ACK" => "PONG" }
    ipaws_acknowledgement = TMS::IpawsAcknowledgement.new(client, '/ipaws/acknowledgement', {})
    ipaws_acknowledgement.client.should_receive('get').with(ipaws_acknowledgement.href).and_return(
      double('response', :status => 200, :body => response_body)
    )
    ipaws_acknowledgement.get.should == ipaws_acknowledgement
    ipaws_acknowledgement.ACK.should == "PONG"
  end

end
