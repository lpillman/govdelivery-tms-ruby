module TSMS #:nodoc:
  class InboundMessage
    include InstanceResource

    readonly_attributes :created_at, :completed_at, :from, :body, :to
  end
end