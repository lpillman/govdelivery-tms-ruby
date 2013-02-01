module TMS #:nodoc:
  class EmailRecipient
    include InstanceResource

    writeable_attributes :email
    readonly_attributes :completed_at
  end
end