class TMS::Emails
  include TMS::CollectionResource
end

class TMS::VoiceMessages
  include TMS::CollectionResource
end

class TMS::SmsMessages
  include TMS::CollectionResource
end

class TMS::EmailMessages
  include TMS::CollectionResource
end

class TMS::Recipients
  include TMS::CollectionResource
end

class TMS::EmailRecipients
  include TMS::CollectionResource
end

# A collection of Keyword objects.
#
# === Example
#    keywords = client.keywords.get
#
class TMS::Keywords
  include TMS::CollectionResource
end

class TMS::InboundSmsMessages
  include TMS::CollectionResource
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
class TMS::CommandTypes
  include TMS::CollectionResource
end

class TMS::Commands
  include TMS::CollectionResource
end