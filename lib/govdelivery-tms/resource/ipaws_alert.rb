module TMS
  class IpawsAlert

    include InstanceResource

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

    attr_accessor :ipaws_response

    def process_response(response, method)
      # All IPAWS responses are 200, even if there are errors.
      # Capture the IPAWS response on a 200 response to POST (create alert)
      if method == :post && response.status == 200
        self.ipaws_response = response.body
        true
      else
        self.ipaws_response = nil
        super
      end
    end

  end
end