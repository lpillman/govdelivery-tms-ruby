module TSMS #:nodoc:
  class Email
    include InstanceResource

    writeable_attributes :body, :from, :subject
    readonly_attributes :created_at, :completed_at
    collection_attribute :recipients, 'EmailRecipients'
  end
end