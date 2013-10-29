module TMS #:nodoc:
end

require 'active_support'
require 'tms_client/version'
require 'faraday'
require 'faraday_middleware'

require 'tms_client/link_header'
require 'tms_client/util/hal_link_parser'
require 'tms_client/util/core_ext'
require 'tms_client/connection'
require 'tms_client/client'
require 'tms_client/logger'
require 'tms_client/base'
require 'tms_client/instance_resource'
require 'tms_client/collection_resource'
require 'tms_client/errors'

require 'tms_client/resource/collections'
require 'tms_client/resource/recipient'
require 'tms_client/resource/email_recipient'
require 'tms_client/resource/email_recipient_open'
require 'tms_client/resource/email_recipient_click'
require 'tms_client/resource/sms_message'
require 'tms_client/resource/voice_message'
require 'tms_client/resource/email_message'
require 'tms_client/resource/inbound_sms_message'
require 'tms_client/resource/command_type'
require 'tms_client/resource/command_action'
require 'tms_client/resource/command'
require 'tms_client/resource/keyword'

