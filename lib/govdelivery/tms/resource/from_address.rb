module GovDelivery::TMS #:nodoc:
  class FromAddress
    include InstanceResource

    # @!parse attr_accessor :from_email, :reply_to_email, :bounce_email, :is_default
    writeable_attributes :from_email, :reply_to_email, :bounce_email, :is_default

    readonly_attributes  :created_at
  end
end
