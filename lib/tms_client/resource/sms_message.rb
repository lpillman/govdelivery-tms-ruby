module TMS #:nodoc:
  # An SMSMessage is used to create and send a text message to a collection of Recipient
  # objects.
  # 
  #
  # ==== Attributes  
  # 
  # * +body+ - The content of the SMS.  This field will be truncated to 160 characters. 
  # 
  # === Example
  #    sms = client.sms_messages.build(:body => "Hello")
  #    sms.recipients.build(:phone => "+18001002000")
  #    sms.post
  #    sms.get
  class SmsMessage
    include InstanceResource

    ##
    # :attr_accessor: body
    writeable_attributes :body

    ##
    # :attr_reader: created_at

    ##
    # :attr_reader: completed_at

    ##
    # :attr_reader: status
    readonly_attributes :created_at, :completed_at, :status

    ##
    # A CollectionResource of Recipient objects
    collection_attributes :recipients
  end
end