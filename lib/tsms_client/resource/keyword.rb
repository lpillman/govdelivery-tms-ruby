module TSMS #:nodoc:
  # A Keyword is a word that TSMS will detect in an incoming SMS message.  Keywords can have Commands, and
  # when an incoming text message has a keyword, TSMS will execute the keyword's Commands. 
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

    writeable_attributes :name
    collection_attributes :commands

  end
end