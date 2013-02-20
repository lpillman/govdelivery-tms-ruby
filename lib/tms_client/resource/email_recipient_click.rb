module TMS #:nodoc:
  class EmailRecipientClick
    include InstanceResource

    ##
    # :attr_reader: event_at

    ##
    # :attr_reader: url
    readonly_attributes :event_at, :url
  end
end
