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
    cog_profile.client.should_receive('get').with(cog_profile.href).and_return(
      double('response', :status => 200, :body => response_body)
    )
    cog_profile.get.should == cog_profile
    cog_profile.cogid.should == "120082"

    cog_profile.name.should == "GovDelivery"
    cog_profile.description.should == "GovDelivery"
    cog_profile.categoryName.should == "IPAWS-OPEN"
    cog_profile.organizationName.should == "CIV"
    cog_profile.cogEnabled.should == "Y"
    cog_profile.caeAuthorized.should == "Y"
    cog_profile.caeCmasAuthorized.should == "Y"
    cog_profile.eanAuthorized.should == "N"
    cog_profile.allEventCode.should == "N"
    cog_profile.allGeoCode.should == "N"
    cog_profile.easAuthorized.should == "Y"
    cog_profile.cmasAlertAuthorized.should == "Y"
    cog_profile.cmamTextAuthorized.should == "Y"
    cog_profile.publicAlertAuthorized.should == "Y"
    cog_profile.broadcastAuthorized.should == "N"
    cog_profile.email.should == "joe.bloom@govdelivery.com"
    cog_profile.eventCodes.should == [
      {"ALL"=>"FRW"},
      {"ALL"=>"SVR"},
      {"ALL"=>"SPW"},
      {"ALL"=>"LAE"},
      {"ALL"=>"CAE"},
      {"ALL"=>"WSW"},
      {"ALL"=>"CEM"}
    ]
    cog_profile.geoCodes.should == [
      {"SAME"=>"039035"}
    ]
  end

end
