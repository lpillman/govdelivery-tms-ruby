module TMS #:nodoc:
  class EmailMessage
    include InstanceResource

    writeable_attributes :body, :from_name, :subject
    readonly_attributes :created_at, :status
    collection_attribute :recipients, 'EmailRecipients'
    collection_attribute :opened, 'EmailRecipients'
    collection_attribute :clicked, 'EmailRecipients'
  end
end