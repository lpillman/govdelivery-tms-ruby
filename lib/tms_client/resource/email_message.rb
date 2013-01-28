module TMS #:nodoc:
  class EmailMessage
    include InstanceResource

    writeable_attributes :body, :from_name, :subject
    readonly_attributes :created_at, :completed_at
    collection_attribute :recipients, 'EmailRecipients'
  end
end