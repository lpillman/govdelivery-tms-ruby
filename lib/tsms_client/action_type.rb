module TSMS #:nodoc:
  # ActionType is a pair of values (name, fields) that can be attached
  # to a keyword. 
  class ActionType

    include InstanceResource
    
    readonly_attributes :name, :fields
  end
end