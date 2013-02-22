module TMS #:nodoc:
  class EmailRecipient
    include InstanceResource

    # @!parse attr_accessor :email
    writeable_attributes :email

    # @!parse attr_reader :completed_at
    readonly_attributes :completed_at

    ##
    # A CollectionResource of EmailRecipientOpens for this EmailRecipient
    collection_attribute :opens, 'EmailRecipientOpens'

    ##
    # A CollectionResource of EmailRecipientClicks for this EmailRecipient
    collection_attribute :clicks, 'EmailRecipientClicks'
  end
end
