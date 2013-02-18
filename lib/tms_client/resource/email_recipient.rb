module TMS #:nodoc:
  class EmailRecipient
    include InstanceResource

    ##
    # :attr_accessor: email
    writeable_attributes :email

    ##
    # :attr_reader: completed_at
    readonly_attributes :completed_at

    ##
    # A CollectionResource of EmailRecipientOpens for this EmailRecipient
    collection_attribute :opens, 'EmailRecipientOpens'
  end
end
