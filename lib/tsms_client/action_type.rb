module TSMS
  class ActionType
    include InstanceResource
    
    readonly_attributes :name, :fields
  end
end