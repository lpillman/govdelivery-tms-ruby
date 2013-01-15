module TMS #:nodoc:
  class EmailRecipient
    include InstanceResource

    writeable_attributes :email
  end
end