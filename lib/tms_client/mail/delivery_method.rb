require 'tms_client'
require 'mail'
require 'mail/check_delivery_params'
module TMS
  module Mail
    # Use TMS from the mail gem or ActionMailer as a delivery method.
    #
    #   # e.g. in config/initializers/tms.rb
    #   require 'tms_client/mail/delivery_method'
    #
    #   Rails.configuration.action_mailer.delivery_method = :govdelivery_tms
    #   Rails.configuration.action_mailer.govdelivery_tms_settings = {
    #     :username=>'email@foo.com',
    #     :password=>'pass',
    #     :api_root=>'https://stage-tms.govdelivery.com'
    #     }
    class DeliveryMethod
      include ::Mail::CheckDeliveryParams

      def initialize(values)
        self.settings = values
      end

      attr_accessor :settings

      def deliver!(mail)
        check_params(mail)
        raise TMS::Errors::NoRelation.new('email_messages', client) unless client.respond_to?(:email_messages)

        envelope_from = mail.return_path || mail.sender || mail.from_addrs.first

        tms_message = client.email_messages.build(
          :from_name => mail[:from].display_names.first,
          :subject => mail.subject,
          :body => mail.body.to_s || mail.html_part.body.to_s || mail.text_part.body.to_s
        )

        mail.to.each { |recip| tms_message.recipients.build(:email => recip) }
        tms_message.post!
        tms_message
      end

      def client
        @client ||= TMS::Client.new(settings[:username], settings[:password], settings)
      end
    end
  end
end

if defined?(ActionMailer)
  ActionMailer::Base.add_delivery_method :govdelivery_tms, TMS::Mail::DeliveryMethod, {
    :username => nil,
    :password => nil,
    :logger => ActionMailer::Base.logger,
    :api_root => TMS::Client::DEFAULTS[:api_root]}
end