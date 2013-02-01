module TMS #:nodoc:
  class SmsMessage
    include InstanceResource

    writeable_attributes :from, :body, :subject
    readonly_attributes :created_at, :completed_at, :status
    collection_attributes :recipients
  end
end