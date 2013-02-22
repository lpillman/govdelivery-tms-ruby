TMS Client 
===========
This is a reference Ruby client to interact with the GovDelivery TMS REST API.

Installation
------------
### Using Bundler
``` ruby
gem 'tms_client'
```

### Standalone
```
$ gem install tms_client
```


Connecting
----------
Loading an instance of `TMS::Client` will automatically connect to the API to query the available resources for your account.

``` ruby
client = TMS::Client.new('username', 'password', :api_root => 'https://stage-tms.govdelivery.com')
```

Messages
--------

### Loading messages
Sms, Email, and voice messages can be retrieved with the `get` collection method.  Messages are paged in groups of 50.  To retrieve another page, used the `next` method.  This method will not be defined if another page is not available.

``` ruby
client.sms_messages.get        # get the first page of sms messages
client.sms_messages.next.get   # get the next page of sms messages
```


### Sending an SMS Message

``` ruby
message = client.sms_messages.build(:body=>'Test Message!')
message.recipients.build(:phone=>'5551112222')
message.recipients.build(:phone=>'5551112223')
message.recipients.build # invalid - no phone
message.post             # true
message.recipients.collection.detect{|r| r.errors } # {"phone"=>["is not a number"]}
# save succeeded, but we have one bad recipient
message.href             # "/messages/sms/87"
message.get              # <TMS::SmsMessage href=/messages/sms/87 attributes={...}>
```

### Sending Email
``` ruby
message = client.email_messages.build(:body=>"<p><a href='http://example.com'>Visit here</a>", :subject => 'Hey')
message.recipients.build(:email=>'example1@example.com')
message.recipients.build(:email=>'example2@example.com')
message.post             # true
message.recipients.collection.detect{|r| r.errors } # {"phone"=>["is not a number"]}
# save succeeded, but we have one bad recipient
message.href             # "/messages/email/87"
message.get              # <TMS::EmailMessage href=/messages/email/88 attributes={...}>
```

### Sending an Voice Message

``` ruby
message = client.voice_messages.build(:play_url=>'www.testmessage.com')
message.recipients.build(:phone=>'5551112222')
message.recipients.build(:phone=>'5551112223')
message.recipients.build # invalid - no phone
message.post             # true
message.recipients.collection.detect{|r| r.errors } # {"phone"=>["is not a number"]}
# save succeeded, but we have one bad recipient
message.href             # "/messages/voice/87"
message.get              # <TMS::VoiceMessage href=/messages/voice/87 attributes={...}>
```

Metrics
-------
### Viewing recipients that clicked on a link in an email
```ruby
email_message.get
email_message.clicked.get
email_message.clicked.collection # => [<#EmailRecipient>,...]
```

### Viewing recipients that opened an email
```ruby
email_message.get
email_message.opened.get
email_message.opened.collection # => [<#EmailRecipient>,...]
```

### Viewing a list of statistics for a recipient
```ruby
email_recipient.clicks.get.collection #=> [<#EmailRecipientClick>,...]

email_recipient.opens.get.collection #=> [<#EmailRecipientOpen>,...]
```

Configuring 2-way SMS
---------------------

### Listing Command Types
Command Types are the available commands that can be used to respond to an incoming SMS message.  

``` ruby 
command_types = client.command_types.get
command_types.collection.each do |at|
  puts at.name   # "forward"
  puts at.fields # ["url", "http_method", ...]
end
````

### Managing Keywords
Keywords are chunks of text that are used to match an incoming SMS message. 

``` ruby 
# CRUD
keyword = client.keywords.build(:name => "BUSRIDE")
keyword.post                # true
keyword.name                # 'busride'
keyword.name = "TRAINRIDE"
keyword.put                 # true
keyword.name                # 'trainride'
keyword.delete              # true

# list
keywords = client.keywords.get
keywords.collection.each do |k|
  puts k.name
end
```

### Managing Commands
Commands have a command type and one or more keywords.  The example below configures the system to respond to an incoming SMS message containing the string "RIDE" (or "ride") by forwarding an http POST to `http://example.com/new_url`.  The POST body variables are documented in GovDelivery's [TMS REST API documentation](https://govdelivery.atlassian.net/wiki/display/PM/TMS+Customer+API+Documentation#TMSCustomerAPIDocumentation-Configuring2-waySMS "GovDelivery TMS REST API").

```ruby
# CRUD
keyword = client.keywords.build(:name => "RIDE")
keyword.post
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


Logging
-------

Any instance of a [Logger](http://www.ruby-doc.org/stdlib-1.9.3/libdoc/logger/rdoc/Logger.html "Ruby Logger")-like class can be passed in to the client; incoming and outgoing request information will then be logged to that instance. 

The example below configures `TMS::Client` to log to STDOUT:

``` ruby
logger = Logger.new(STDOUT)
client = TMS::Client.new('username', 'password', :logger => logger)

```

Compatibility
-------------
This project is tested and compatible with REE 1.8.7 and MRI 1.9.3.  

License
-------
Copyright (c) 2013, GovDelivery, Inc.

All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
* Neither the name of GovDelivery nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
