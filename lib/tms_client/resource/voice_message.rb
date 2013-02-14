module TMS #:nodoc:
  # A VoiceMessage is used to create and send a voice message to a collection of Recipient
  # objects.  The recipients are called and the provided +play_url+ is 
  # played to them.  Accepted sound formats include +wav+, +mp3+, and +aiff+. 
  # 
  #
  # ==== Attributes  
  # 
  # * +play_url+ - The url to the sound file to be played back to the call recipients
  # 
  # === Example
  #    voice_message = client.voice_messages.build(:play_url => "http://example.com/emergency_weather.mp3")
  #    voice_message.recipients.build(:phone => "+18001002000")
  #    voice_message.post
  #    voice_message.get
  class VoiceMessage
    include InstanceResource

    ## 
    # :attr_accessor: play_url
    writeable_attributes :play_url

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

    def self.to_s
      "VoiceMessage"
    end
  end
end