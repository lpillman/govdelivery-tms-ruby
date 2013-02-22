module TMS #:nodoc:
  # An EmailMessage is used to create and send a email to a collection of EmailRecipient
  # objects.  Certain metrics are available after the email is sent, including
  # the collection of recipients who clicked or opened the email. 
  # 
  #
  # ==== Attributes  
  # 
  # * +from_name+ - The name of the person or entity sending the email.  
  # * +subject+   - The subject of the email
  # * +body+      - The body of the email
  #
  # 
  # === Example
  # Sending a message
  #    email_message = client.email_messages.build(:subject => "Great news!", :body => "You win! <a href='http://example.com/'>click here</a>.")
  #    email_message.recipients.build(:email => "john@example.com")
  #    email_message.recipients.build(:email => "jeff@example.com")
  #    email_message.post
  #    email_message.get
  #
  # Viewing recipients that clicked on a link in the email
  #    email_message.get
  #    email_message.clicked.get
  #    email_message.clicked.collection # => [<#EmailRecipient>,...]
  #
  # Viewing recipients that opened the email
  #    email_message.get
  #    email_message.opened.get
  #    email_message.opened.collection # => [<#EmailRecipient>,...]
  class EmailMessage
    include InstanceResource

    # @!parse attr_accessor :body, :from_name, :subject
    writeable_attributes :body, :from_name, :subject

    # @!parse attr_reader :created_at, :status
    readonly_attributes :created_at, :status

    ##
    # A CollectionResource of EmailRecipients on this email
    collection_attribute :recipients, 'EmailRecipients'

    ##
    # A CollectionResource of EmailRecipients that opened this email
    collection_attribute :opened, 'EmailRecipients'

    ##
    # A CollectionResource of EmailRecipients that clicked on at least one link in this email
    collection_attribute :clicked, 'EmailRecipients'
  end
end