module TSMS #:nodoc:
end

require 'active_support'
require 'tsms_client/version'
require 'faraday'
require 'link_header'
require 'faraday_middleware'

require 'tsms_client/util/hal_link_parser'
require 'tsms_client/util/core_ext'
require 'tsms_client/connection'
require 'tsms_client/client'
require 'tsms_client/logger'
require 'tsms_client/base'
require 'tsms_client/instance_resource'
require 'tsms_client/collection_resource'
require 'tsms_client/request'

require 'tsms_client/resource/recipients'
require 'tsms_client/resource/recipient'
require 'tsms_client/resource/sms_message'
require 'tsms_client/resource/voice_message'
require 'tsms_client/resource/sms_messages'
require 'tsms_client/resource/voice_messages'
require 'tsms_client/resource/inbound_message'
require 'tsms_client/resource/inbound_messages'
require 'tsms_client/resource/command_type'
require 'tsms_client/resource/command_types'
require 'tsms_client/resource/command'
require 'tsms_client/resource/commands'
require 'tsms_client/resource/keyword'
require 'tsms_client/resource/keywords'