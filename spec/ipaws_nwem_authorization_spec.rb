require 'spec_helper'

describe TMS::IpawsNwemAuthorization do

  it 'gets IPAWS NWEM Authorization from client' do
    client = double(:client)
    response_body = { "cogid" => "true" }
    nwem_authorization = TMS::IpawsNwemAuthorization.new(client, '/ipaws/nwem_authorization', {})
    expect(nwem_authorization.client).to receive('get').with(nwem_authorization.href).and_return(
      double('response', status: 200, body: response_body)
    )
    expect(nwem_authorization.get).to eq(nwem_authorization)
    expect(nwem_authorization.cogid).to eq("true")
  end

end
