module TSMS
  class VoiceMessage
    include InstanceResource

    writeable_attributes :url
    readonly_attributes :created_at, :completed_at
    collection_attributes :recipients

    def self.to_s
      "Message"
    end
  end
end