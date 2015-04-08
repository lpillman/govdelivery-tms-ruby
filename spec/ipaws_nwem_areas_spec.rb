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

    expect(nwem_areas.client).to receive('get').with(nwem_areas.href).and_return(
      double('response', status: 200, body: response_body, headers: {})
    )
    expect(nwem_areas.get).to eq(nwem_areas)
    expect(nwem_areas.collection.size).to eq(2)

    nwem_area = nwem_areas.collection[0]
    expect(nwem_area.countyFipsCd).to eq('51013')
    expect(nwem_area.countyName).to eq('Arlington')
    expect(nwem_area.geoType).to eq('C')
    expect(nwem_area.stateCd).to eq('VA')
    expect(nwem_area.stateFips).to eq('51')
    expect(nwem_area.stateName).to eq('Virginia')
    expect(nwem_area.zoneCd).to eq('054')
    expect(nwem_area.zoneName).to eq('Arlington/Falls Church/Alexandria')

    nwem_area = nwem_areas.collection[1]
    expect(nwem_area.countyFipsCd).to eq('51510')
    expect(nwem_area.countyName).to eq('City of Alexandria')
    expect(nwem_area.geoType).to eq('C')
    expect(nwem_area.stateCd).to eq('VA')
    expect(nwem_area.stateFips).to eq('51')
    expect(nwem_area.stateName).to eq('Virginia')
    expect(nwem_area.zoneCd).to eq('054')
    expect(nwem_area.zoneName).to eq('Arlington/Falls Church/Alexandria')
  end

end
