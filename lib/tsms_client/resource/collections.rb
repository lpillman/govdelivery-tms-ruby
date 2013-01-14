class TSMS::Emails
  include TSMS::CollectionResource
end

class TSMS::VoiceMessages
  include TSMS::CollectionResource
end

class TSMS::SmsMessages
  include TSMS::CollectionResource
end

class TSMS::Recipients
  include TSMS::CollectionResource
end

# A collection of Keyword objects.
#
# === Example
#    keywords = client.keywords.get
#
class TSMS::Keywords
  include TSMS::CollectionResource
end

class TSMS::InboundMessages
  include TSMS::CollectionResource
end

# A collection of CommandType instances.
# This resource changes infrequently.  It may be used to dynamically construct a
# user interface for configuring arbitrary SMS keywords for an account.
#
# This resource is read-only.
#
# === Example
#    client.command_types.get
#    client.command_types.collection.each {|at| ... }
class TSMS::CommandTypes
  include TSMS::CollectionResource
end