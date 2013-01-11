Tsms Client 
===========
This is a ruby client to interact with the GovDelivery TSMS REST API.


# Connecting

``` ruby
client = TSMS::Client.new('username', 'password', :api_root => 'https://tsms.govdelivery.com')

```

# Getting messages

``` ruby
client.subresources            #=> {"messages"=><TSMS::Messages href=/messages collection=[]>}
client.messages                #=> <TSMS::Messages href=/messages collection=[]>
client.sms_messages.get        #=> #lots of sms stuff
client.sms_messages.next       #=> <TSMS::Messages href=/messages/page/2 collection=[]> (if there is a second page)
client.sms_messages.next.get   #=> # more messages...
client.voice_messages.get      #=> #lots of voice stuff
client.voice_messages.next     #=> <TSMS::Messages href=/messages/page/2 collection=[]> (if there is a second page)
client.voice_messages.next.get #=> # more messages...
```


# Sending an SMS Message

``` ruby
message = client.sms_messages.build(:short_body=>'Test Message!')
message.recipients.build(:phone=>'5551112222')
message.recipients.build(:phone=>'5551112223')
message.recipients.build # invalid - no phone
message.post             #=> true
message.recipients.collection.detect{|r| r.errors } #=> <TSMS::Recipient href= attributes={:provided_phone=>"", :provided_country_code=>nil, :phone=>nil, :country_code=>"1", :status=>nil, :created_at=>nil, :sent_at=>nil, :completed_at=>nil, :errors=>{"phone"=>["is not a number"]}}>
# save succeeded, but we have one bad recipient
message.href             #=> "/messages/87"
message.get              #=> <TSMS::Message href=/messages/87 attributes={...}>
```

# Sending an Voice Message

``` ruby
message = client.voice_messages.build(:url=>'www.testmessage.com')
message.recipients.build(:phone=>'5551112222')
message.recipients.build(:phone=>'5551112223')
message.recipients.build # invalid - no phone
message.post             #=> true
message.recipients.collection.detect{|r| r.errors } #=> <TSMS::Recipient href= attributes={:provided_phone=>"", :provided_country_code=>nil, :phone=>nil, :country_code=>"1", :status=>nil, :created_at=>nil, :sent_at=>nil, :completed_at=>nil, :errors=>{"phone"=>["is not a number"]}}>
# save succeeded, but we have one bad recipient
message.href             #=> "/messages/87"
message.get              #=> <TSMS::Message href=/messages/87 attributes={...}>
```

# Listing Action Types

``` ruby 
action_types = client.action_types.get
action_types.collection.each do |at|
  puts at.name   #=> "forward"
  puts at.fields #=> ["url", "http_method", ...]
end
````

# Managing Keywords

``` ruby 
# CRUD
keyword = client.keywords.build(:name => "BUSRIDE")
keyword.post                #=> true
keyword.name                #=> 'busride'
keyword.name = "TRAINRIDE"
keyword.put                 #=> true
keyword.name                #=> 'trainride'
keyword.delete              #=> true

# list
keywords = client.keywords.get
keywords.collection.each do |k|
  puts k.name
end
```

# Logging
Any instance of a [Logger](http://www.ruby-doc.org/stdlib-1.9.3/libdoc/logger/rdoc/Logger.html "Ruby Logger")-like class can be passed in to the client; incoming and outgoing
request information will then be logged to that instance. 

The example below configures `TSMS::Client` to log to STDOUT:

``` ruby
logger = Logger.new(STDOUT)
client = TSMS::Client.new('username', 'password', :logger => logger)

```

