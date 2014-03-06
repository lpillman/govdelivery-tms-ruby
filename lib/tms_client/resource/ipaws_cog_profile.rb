module TMS
  class IpawsCogProfile

    include InstanceResource

    readonly_attributes(
      :cogid, 
      :name, 
      :description, 
      :categoryName, 
      :organizationName, 
      :cogEnabled,
      :caeAuthorized,
      :caeCmasAuthorized,
      :eanAuthorized,
      :allEventCode,
      :allGeoCode,
      :easAuthorized,
      :cmasAlertAuthorized,
      :cmamTextAuthorized,
      :publicAlertAuthorized,
      :broadcastAuthorized,
      :email,
      :eventCodes,
      :geoCodes
    )

  end
end