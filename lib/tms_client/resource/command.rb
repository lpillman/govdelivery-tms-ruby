module TMS #:nodoc:
  # A command is a combination of behavior and parameters that should be executed 
  # when an incoming SMS message matches the associated Keyword.
  #
  # ==== Attributes  
  # 
  # * +name+ - The name of the command.  This will default to the command_type if not supplied. 
  # * +command_type+ - The type of this command.  A list of valid types can be found by querying the CommandType list. 
  # * +params+ - A Hash of string/string pairs used as configuration for this command.  
  # 
  # === Examples
  #    command = keyword.commands.build(:name => "subscribe to news", :command_type => "dcm_subscribe", :dcm_account_code => "NEWS", :dcm_topic_codes => "NEWS_1, NEWS_2")
  #    command.post
  #    command.dcm_topic_codes += ", NEWS_5"
  #    command.put
  #    command.delete
  class Command
    include InstanceResource

    
    ##
    # :attr_accessor: name
    
    ##
    # :attr_accessor: command_type
    
    ##
    # :attr_accessor: params

    ##
    # :attr_reader: created_at

    ##
    # :attr_reader: updated_at

    writeable_attributes :name, :command_type, :params
    readonly_attributes :created_at, :updated_at

  end
end