module TMS
  class IpawsNwemArea

    include InstanceResource

    readonly_attributes(
      :countyFipsCd,
      :countyName,
      :geoType,
      :stateCd,
      :stateFips,
      :stateName,
      :zoneCd,
      :zoneName
    )

  end
end