module TMS
  module IpawsResponse
    
    attr_accessor :ipaws_response

    def process_response(response, method)
      if response.status == 200
        # All IPAWS responses are 200, even if there are errors.
        self.ipaws_response = response.body
        true
      else
        self.ipaws_response = nil
        super
      end
    end

  end
end