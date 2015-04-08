require 'spec_helper'

describe TMS::IpawsCogProfile do

  it 'gets IPAWS cog profile from client' do
    client = double(:client)
    response_body = {
      "cogid"=>"120082",
      "name"=>"GovDelivery",
      "description"=>"GovDelivery",
      "categoryName"=>"IPAWS-OPEN",
      "organizationName"=>"CIV",
      "cogEnabled"=>"Y",
      "caeAuthorized"=>"Y",
      "caeCmasAuthorized"=>"Y",
      "eanAuthorized"=>"N",
      "allEventCode"=>"N",
      "allGeoCode"=>"N",
      "easAuthorized"=>"Y",
      "cmasAlertAuthorized"=>"Y",
      "cmamTextAuthorized"=>"Y",
      "publicAlertAuthorized"=>"Y",
      "broadcastAuthorized"=>"N",
      "email"=>"joe.bloom@govdelivery.com",
      "eventCodes" => [
        {"ALL"=>"FRW"},
        {"ALL"=>"SVR"},
        {"ALL"=>"SPW"},
        {"ALL"=>"LAE"},
        {"ALL"=>"CAE"},
        {"ALL"=>"WSW"},
        {"ALL"=>"CEM"}
      ],
      "geoCodes" => [
        {"SAME"=>"039035"}
      ]
    }
    cog_profile = TMS::IpawsCogProfile.new(client, '/ipaws/cog_profile', {})
    expect(cog_profile.client).to receive('get').with(cog_profile.href).and_return(
      double('response', :status => 200, :body => response_body)
    )
    expect(cog_profile.get).to eq(cog_profile)
    expect(cog_profile.cogid).to eq("120082")

    expect(cog_profile.name).to eq("GovDelivery")
    expect(cog_profile.description).to eq("GovDelivery")
    expect(cog_profile.categoryName).to eq("IPAWS-OPEN")
    expect(cog_profile.organizationName).to eq("CIV")
    expect(cog_profile.cogEnabled).to eq("Y")
    expect(cog_profile.caeAuthorized).to eq("Y")
    expect(cog_profile.caeCmasAuthorized).to eq("Y")
    expect(cog_profile.eanAuthorized).to eq("N")
    expect(cog_profile.allEventCode).to eq("N")
    expect(cog_profile.allGeoCode).to eq("N")
    expect(cog_profile.easAuthorized).to eq("Y")
    expect(cog_profile.cmasAlertAuthorized).to eq("Y")
    expect(cog_profile.cmamTextAuthorized).to eq("Y")
    expect(cog_profile.publicAlertAuthorized).to eq("Y")
    expect(cog_profile.broadcastAuthorized).to eq("N")
    expect(cog_profile.email).to eq("joe.bloom@govdelivery.com")
    expect(cog_profile.eventCodes).to eq([
      {"ALL"=>"FRW"},
      {"ALL"=>"SVR"},
      {"ALL"=>"SPW"},
      {"ALL"=>"LAE"},
      {"ALL"=>"CAE"},
      {"ALL"=>"WSW"},
      {"ALL"=>"CEM"}
    ])
    expect(cog_profile.geoCodes).to eq([
      {"SAME"=>"039035"}
    ])
  end

end
