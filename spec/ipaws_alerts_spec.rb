require 'spec_helper'

describe TMS::IpawsAlert do

  it 'post new IPAWS alerts to client, and capture status response from IPAWS' do
    client = double(:client)

    response_body = {
      "identifier"=>"CAP12-TEST-1397743203",
      "statuses"=> [
        {
          "CHANNELNAME"=>"CAPEXCH",
          "STATUSITEMID"=>"200",
          "ERROR"=>"N",
          "STATUS"=>"Ack"
        },
        {
          "CHANNELNAME"=>"CAPEXCH",
          "STATUSITEMID"=>"202",
          "ERROR"=>"N",
          "STATUS"=>"alert-signature-is-valid"
        },
        {
          "CHANNELNAME"=>"IPAWS",
          "STATUSITEMID"=>"300",
          "ERROR"=>"N",
          "STATUS"=>"Ack"
        },
        {
          "CHANNELNAME"=>"NWEM",
          "STATUSITEMID"=>"401",
          "ERROR"=>"N",
          "STATUS"=>"message-not-disseminated-as-NWEM"
        },
        {
          "CHANNELNAME"=>"EAS",
          "STATUSITEMID"=>"501",
          "ERROR"=>"N",
          "STATUS"=>"message-not-disseminated-as-EAS"
        },
        {
          "CHANNELNAME"=>"CMAS",
          "STATUSITEMID"=>"600",
          "ERROR"=>"N",
          "STATUS"=>"Ack"
        },
        {
          "CHANNELNAME"=>"PUBLIC",
          "STATUSITEMID"=>"800",
          "ERROR"=>"N",
          "STATUS"=>"Ack"
        }
      ]
    }

    alert_attributes = {
      identifier: "CAP12-TEST-123",
      sender: 'test@open.com',
      sent: "2014-04-18T15:02:26-05:00",
      status: 'Actual',
      msgType: 'Alert',
      source: 'IPAWS-TEST',
      scope: 'Public',
      addresses: '999',
      code: ['IPAWSv1.0'],
      note: 'test',
      incidents: 'IPAWS-9999',
      info: [
        {
          language: 'en-US',
          category: ['Safety'],
          event: 'CIVIL EMERGENCY MESSAGE',
          responseType: ['Shelter'],
          urgency: 'Immediate',
          severity: 'Extreme',
          certainty: 'Observed',
          audience: 'Public',
          eventCode: [
            { valueName: 'SAME', value: 'SVR'}
          ],
          effective: "2014-04-18T15:02:26-05:00",
          expires: "2014-04-18T15:02:26-05:00",
          senderName: 'IPAWS-Test',
          headline: 'FLash Flood Warning',
          description: 'Severe Weather Warning - Flooding',
          instruction: 'Take Shelter',
          parameter: [
            { valueName: 'timezone', value: 'CST' }
          ],
          area: [
            {
              areaDesc: 'Fairfax County',
              geocode: { valueName: 'SAME', value: '039035' }
            }
          ]
        }
      ]
    }

    alerts = TMS::IpawsAlerts.new(client, '/ipaws/alerts')
    alert = alerts.build(alert_attributes)

    expect(alert.identifier).to eq("CAP12-TEST-123")
    expect(alert.sender).to eq('test@open.com')
    expect(alert.sent).to eq("2014-04-18T15:02:26-05:00")
    expect(alert.status).to eq('Actual')
    expect(alert.msgType).to eq('Alert')
    expect(alert.source).to eq('IPAWS-TEST')
    expect(alert.scope).to eq('Public')
    expect(alert.addresses).to eq('999')
    expect(alert.code).to eq(['IPAWSv1.0'])
    expect(alert.note).to eq('test')
    expect(alert.incidents).to eq('IPAWS-9999')
    expect(alert.info).to eq([
      {
        language: 'en-US',
        category: ['Safety'],
        event: 'CIVIL EMERGENCY MESSAGE',
        responseType: ['Shelter'],
        urgency: 'Immediate',
        severity: 'Extreme',
        certainty: 'Observed',
        audience: 'Public',
        eventCode: [
          { valueName: 'SAME', value: 'SVR'}
        ],
        effective: "2014-04-18T15:02:26-05:00",
        expires: "2014-04-18T15:02:26-05:00",
        senderName: 'IPAWS-Test',
        headline: 'FLash Flood Warning',
        description: 'Severe Weather Warning - Flooding',
        instruction: 'Take Shelter',
        parameter: [
          { valueName: 'timezone', value: 'CST' }
        ],
        area: [
          {
            areaDesc: 'Fairfax County',
            geocode: { valueName: 'SAME', value: '039035' }
          }
        ]
      }
    ])

    expect(alert.client).to receive('post').with(alert).and_return(double('response', :status => 200, :body => response_body))
    expect(alert.post).to eq(true)
    expect(alert.ipaws_response).to eq(response_body)

    expect(alert.identifier).to eq("CAP12-TEST-123")
    expect(alert.sender).to eq('test@open.com')
    expect(alert.sent).to eq("2014-04-18T15:02:26-05:00")
    expect(alert.status).to eq('Actual')
    expect(alert.msgType).to eq('Alert')
    expect(alert.source).to eq('IPAWS-TEST')
    expect(alert.scope).to eq('Public')
    expect(alert.addresses).to eq('999')
    expect(alert.code).to eq(['IPAWSv1.0'])
    expect(alert.note).to eq('test')
    expect(alert.incidents).to eq('IPAWS-9999')
    expect(alert.info).to eq([
      {
        language: 'en-US',
        category: ['Safety'],
        event: 'CIVIL EMERGENCY MESSAGE',
        responseType: ['Shelter'],
        urgency: 'Immediate',
        severity: 'Extreme',
        certainty: 'Observed',
        audience: 'Public',
        eventCode: [
          { valueName: 'SAME', value: 'SVR'}
        ],
        effective: "2014-04-18T15:02:26-05:00",
        expires: "2014-04-18T15:02:26-05:00",
        senderName: 'IPAWS-Test',
        headline: 'FLash Flood Warning',
        description: 'Severe Weather Warning - Flooding',
        instruction: 'Take Shelter',
        parameter: [
          { valueName: 'timezone', value: 'CST' }
        ],
        area: [
          {
            areaDesc: 'Fairfax County',
            geocode: { valueName: 'SAME', value: '039035' }
          }
        ]
      }
    ])
  end

end
