module TMS #:nodoc:
  class EmailRecipient
    include InstanceResource

    ##
    # :attr_accessor: email
    writeable_attributes :email

    ##
    # :attr_reader: completed_at
    readonly_attributes :completed_at
  end
end