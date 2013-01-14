module TSMS #:nodoc:
  class EmailRecipient
    include InstanceResource

    writeable_attributes :email
  end
end