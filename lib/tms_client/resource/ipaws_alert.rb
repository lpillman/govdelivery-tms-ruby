module TMS
  class IpawsAlert

    include InstanceResource
    include IpawsResponse

    writeable_attributes(
      :identifier,
      :sender,
      :sent,
      :status,
      :msgType,
      :source,
      :scope,
      :restriction,
      :addresses,
      :code,
      :note,
      :references,
      :incidents,
      :info
    )

  end
end