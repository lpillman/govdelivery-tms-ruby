module TSMS #:nodoc:
  # A collection of ActionType instances. 
  # This resource changes infrequently.  It may be used to dynamically construct a 
  # user interface for configuring arbitrary SMS keywords for an account. 
  class ActionTypes
    include TSMS::CollectionResource
  end
end