module TMS #:nodoc:
  class InboundSmsMessage
    include InstanceResource

    readonly_attributes :created_at, :completed_at, :from, :body, :to
  end
end
