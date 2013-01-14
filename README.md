Tsms Client 
===========
This is a ruby client to interact with the GovDelivery TSMS REST API.


Usage 
-----
# Connecting

``` ruby
client = TSMS::Client.new('username', 'password', :api_root => 'https://tsms.govdelivery.com')

```

# Getting messages

``` ruby
client.subresources            #=> {"messages"=><TSMS::Messages href=/messages collection=[]>}
client.messages                #=> <TSMS::Messages href=/messages collection=[]>
client.sms_messages.get        #=> #lots of sms stuff
client.sms_messages.next       #=> <TSMS::Messages href=/messages/page/2 collection=[]> 
                               #   (if there is a second page)
client.sms_messages.next.get   #=> # more messages...
client.voice_messages.get      #=> #lots of voice stuff
client.voice_messages.next     #=> <TSMS::Messages href=/messages/page/2 collection=[]> 
                               #   (if there is a second page)
client.voice_messages.next.get #=> # more messages...
```


# Sending an SMS Message

``` ruby
message = client.sms_messages.build(:short_body=>'Test Message!')
message.recipients.build(:phone=>'5551112222')
message.recipients.build(:phone=>'5551112223')
message.recipients.build # invalid - no phone
message.post             #=> true
message.recipients.collection.detect{|r| r.errors } #=> {"phone"=>["is not a number"]}
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
message.recipients.collection.detect{|r| r.errors } #=> {"phone"=>["is not a number"]}
# save succeeded, but we have one bad recipient
message.href             #=> "/messages/87"
message.get              #=> <TSMS::Message href=/messages/87 attributes={...}>
```

# Listing Command Types

``` ruby 
command_types = client.command_types.get
command_types.collection.each do |at|
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

# Managing Commands

```ruby
# CRUD
keywords = client.keywords.get
keyword = keywords.collection.first.get
command = keyword.commands.build(
            :name => "Forward to somewhere else", 
            :params => {:url => "http://example.com", :http_method => "get"}, 
            :command_type => :forward)
command.post
command.params = {:url => "http://example.com/new_url", :http_method => "post"}
command.put
command.delete

# list
commands = keyword.commands.get
commands.collection.each do |c|
  puts c.inspect
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

License
-------
Copyright (c) 2013, GovDelivery, Inc.

All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
* Neither the name of GovDelivery nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
