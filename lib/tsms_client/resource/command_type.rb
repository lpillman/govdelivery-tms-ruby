module TSMS #:nodoc:
  # CommandType is a pair of values (name, fields) that can be attached
  # to a keyword. 
  #
  # This resource is read-only. 
  #
  # ==== Attributes  
  #  
  # * +name+ - The name of the command.
  # * +fields+ - An Array of strings representing the different fields on this 
  #   command type.  Field values will always be strings.  
  #  
  class CommandType

    include InstanceResource
    
    readonly_attributes :name, :fields
  end
end