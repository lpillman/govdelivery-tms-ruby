module TSMS #:nodoc:
  # ActionType is a pair of values (name, fields) that can be attached
  # to a keyword. 
  #
  # This resource is read-only. 
  #
  # ==== Attributes  
  #  
  # * +name+ - The name of the action.
  # * +fields+ - An Array of strings representing the different fields on this 
  #   action type.  Field values will always be strings.  
  #  
  class ActionType

    include InstanceResource
    
    readonly_attributes :name, :fields
  end
end