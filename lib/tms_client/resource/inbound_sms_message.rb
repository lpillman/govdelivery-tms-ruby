module TMS #:nodoc:
  class InboundSmsMessage
    include InstanceResource
    ##
    # :attr_reader: created_at
    
    ##
    # :attr_reader: completed_at

    ##
    # :attr_reader: from
    
    ##
    # :attr_reader: body
    
    ##
    # :attr_reader: to

    readonly_attributes :created_at, :completed_at, :from, :body, :to, :command_status
  end
end
