module TMS #:nodoc:
  # CommandType is a pair of values (name, fields) that can be attached
  # to a Keyword (in a Command object).
  #
  # This resource is read-only. 
  #
  # ==== Attributes  
  #  
  # * +name+ - The name of the CommandType.
  # * +fields+ - An Array of strings representing the different fields on this 
  #   CommandType.  Field values will always be strings.  
  #  
  class CommandType

    include InstanceResource
    
    readonly_attributes :name, :fields
  end
end