module TSMS #:nodoc:
  # A collection of CommandType instances. 
  # This resource changes infrequently.  It may be used to dynamically construct a 
  # user interface for configuring arbitrary SMS keywords for an account. 
  #
  # This resource is read-only. 
  # 
  # === Example
  #    client.command_types.get
  #    client.command_types.collection.each {|at| ... }
  class CommandTypes
    include TSMS::CollectionResource
  end
end