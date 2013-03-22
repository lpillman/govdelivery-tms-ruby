module TMS #:nodoc:
  # An EmailMessage is used to create and send a email to a collection of EmailRecipient
  # objects.  Certain metrics are available after the email is sent, including
  # the collection of recipients who clicked or opened the email. 
  #
  # @attr from_name [String]             The name of the person or entity sending the email.  
  # @attr subject   [String]             The subject of the email
  # @attr body      [String]             The body of the email
  # @attr open_tracking_enabled [Boolean] Whether to track opens on this message. Optional, defaults to true.
  # @attr click_tracking_enabled [Boolean] Whether to track clicks on links in this message. Optional, defaults to true.
  # @attr macros [Hash]                A dictionary of key/value pairs to use in the subject and body as default macros. 
  #                              The message-level macros are used when a recipient has no value for a given macro key.
  # 
  # @example Sending a message
  #    email_message = client.email_messages.build(:subject => "Great news!", :body => "You win! <a href='http://example.com/'>click here</a>.")
  #    email_message.recipients.build(:email => "john@example.com")
  #    email_message.recipients.build(:email => "jeff@example.com")
  #    email_message.post
  #    email_message.get
  #
  # @example Viewing recipients that clicked on a link in the email
  #    email_message.get
  #    email_message.clicked.get
  #    email_message.clicked.collection # => [<#EmailRecipient>,...]
  #
  # @example Viewing recipients that opened the email
  #    email_message.get
  #    email_message.opened.get
  #    email_message.opened.collection # => [<#EmailRecipient>,...]
  #
  # @example Using macros
  #    email_message = client.email_messages.build(:subject => "Hello [[user]]", 
  #                                                :body => "Your name is [[name]]",
  #                                                :macros => {:user => "Sir or Madam", :name => "unknown"})
  #    email_message.recipients.build(:email => "jeff@example.com", :macros => {:user => "jexample", :name => "Jeff Example"})
  #    email_message.post
  #
  class EmailMessage
    include InstanceResource

    # @!parse attr_accessor :body, :from_name, :subject, :open_tracking_enabled, :click_tracking_enabled, :macros
    writeable_attributes :body, :from_name, :subject, :open_tracking_enabled, :click_tracking_enabled, :macros

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