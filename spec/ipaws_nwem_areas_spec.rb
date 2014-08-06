require 'spec_helper'

describe TMS::IpawsNwemAreas do

  it 'gets IPAWS NWEM areas from client' do
    client = double(:client)
    response_body = [
      {
        "countyFipsCd"=>"51013",
        "countyName"=>"Arlington",
        "geoType"=>"C",
        "stateCd"=>"VA",
        "stateFips"=>"51",
        "stateName"=>"Virginia",
        "zoneCd"=>"054",
        "zoneName"=>"Arlington/Falls Church/Alexandria"
      },
      {
        "countyFipsCd"=>"51510",
        "countyName"=>"City of Alexandria",
        "geoType"=>"C",
        "stateCd"=>"VA",
        "stateFips"=>"51",
        "stateName"=>"Virginia",
        "zoneCd"=>"054",
        "zoneName"=>"Arlington/Falls Church/Alexandria"
      }
    ]
    nwem_areas = TMS::IpawsNwemAreas.new(client, '/ipaws/nwem_areas')

    nwem_areas.client.should_receive('get').with(nwem_areas.href).and_return(
      double('response', :status => 200, :body => response_body, :headers => {})
    )
    nwem_areas.get.should == nwem_areas
    nwem_areas.collection.size.should == 2

    nwem_area = nwem_areas.collection[0]
    nwem_area.countyFipsCd.should == '51013'
    nwem_area.countyName.should == 'Arlington'
    nwem_area.geoType.should == 'C'
    nwem_area.stateCd.should == 'VA'
    nwem_area.stateFips.should == '51'
    nwem_area.stateName.should == 'Virginia'
    nwem_area.zoneCd.should == '054'
    nwem_area.zoneName.should == 'Arlington/Falls Church/Alexandria'

    nwem_area = nwem_areas.collection[1]
    nwem_area.countyFipsCd.should == '51510'
    nwem_area.countyName.should == 'City of Alexandria'
    nwem_area.geoType.should == 'C'
    nwem_area.stateCd.should == 'VA'
    nwem_area.stateFips.should == '51'
    nwem_area.stateName.should == 'Virginia'
    nwem_area.zoneCd.should == '054'
    nwem_area.zoneName.should == 'Arlington/Falls Church/Alexandria'
  end

end
