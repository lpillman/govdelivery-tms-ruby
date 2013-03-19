module TMS #:nodoc:
  # A Keyword is a word that TMS will detect in an incoming SMS message.  Keywords can have Commands, and
  # when an incoming text message has a keyword, TMS will execute the keyword's Commands. 
  #
  # ==== Attributes  
  # 
  # * +name+ - The name of the keyword.
  #  
  # === Examples
  #   keyword = client.keywords.build(:name => "HOWDY")
  #   keyword.post
  #   keyword.name = "DOODY"
  #   keyword.put
  #   keyword.delete
  class Keyword
    include InstanceResource

    ##
    # :attr_accessor: name
    writeable_attributes :name, :response_text

    ##
    # A CollectionResource of Command objects
    collection_attributes :commands

  end
end