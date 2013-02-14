module TMS #:nodoc:
  class Recipient
    include InstanceResource

    ##
    # :attr_accessor: phone
    writeable_attributes :phone

    ##
    # :attr_reader: formatted_phone

    ##
    # :attr_reader: error_message

    ##
    # :attr_reader: status

    ##
    # :attr_reader: completed_at
    readonly_attributes :formatted_phone, :error_message, :status, :completed_at
  end
end