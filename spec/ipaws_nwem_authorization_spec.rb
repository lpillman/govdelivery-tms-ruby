require 'spec_helper'

describe TMS::IpawsNwemAuthorization do

  it 'gets IPAWS NWEM Authorization from client' do
    client = double(:client)
    response_body = { "cogid" => "true" }
    nwem_authorization = TMS::IpawsNwemAuthorization.new(client, '/ipaws/nwem_authorization', {})
    nwem_authorization.client.should_receive('get').with(nwem_authorization.href).and_return(
      double('response', :status => 200, :body => response_body)
    )
    nwem_authorization.get.should == nwem_authorization
    nwem_authorization.cogid.should == "true"
  end

end
