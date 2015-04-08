module TMS
  module IpawsStaticResource
    def self.included(base)
      base.send(:include, TMS::InstanceResource)
      base.readonly_attributes :value, :description, :cap_exchange, :core_ipaws_profile, :nwem, :eas_and_public, :cmas
    end
  end
end