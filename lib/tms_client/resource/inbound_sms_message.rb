module TMS #:nodoc:
  class InboundSmsMessage
    include InstanceResource
    
    # @!parse attr_reader :created_at, :completed_at, :from, :body, :to
    readonly_attributes :created_at, :completed_at, :from, :body, :to
  end
end
