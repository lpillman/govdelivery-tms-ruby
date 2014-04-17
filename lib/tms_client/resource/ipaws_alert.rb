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

    def post
      process_ipaws_response(client.post(self), :post)  
    end

    def process_ipaws_response(response, method)
      # Since FEMA always responds with 200 to IPAWS CAP alerts, even if there are errors,
      # store the response (which may contain the errors) and return true.
      # However, if a 400 or 500 response is given by XACT, that means there was
      # a permissions problem or a server error, so process those responses normally.
      if response.status == 200
        # All IPAWS responses are 200, even if there are errors.
        self.ipaws_response = response.body
        true
      else
        self.ipaws_response = nil
        process_response(response, method)
      end
    end

  end
end