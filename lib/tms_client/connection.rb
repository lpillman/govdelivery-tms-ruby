class TMS::Connection
  attr_accessor :auth_token, :api_root, :connection, :logger, :debug

  def get(href)
    resp = connection.get("#{href}.json")
    if resp.status != 200
      raise RecordNotFound.new("Could not find resource at #{href} (status #{resp.status})")
    else
      resp.body
    end
  end

  def initialize(opts={})
    self.auth_token = opts[:auth_token]
    self.api_root = opts[:api_root]
    self.logger = opts[:logger]
    self.debug = opts[:debug]
    setup_connection
  end

  def setup_connection
    self.connection = Faraday.new(:url => self.api_root) do |faraday|
      faraday.use TMS::Logger, self.logger if self.logger
      faraday.request :json
      setup_logging(faraday)
      faraday.headers['X-AUTH-TOKEN'] = auth_token
      faraday.headers[:user_agent] = "GovDelivery Ruby TMS::Client #{TMS::VERSION}"
      faraday.response :json, :content_type => /\bjson$/
      faraday.adapter :net_http
    end
  end

  def setup_logging(faraday)
    faraday.use FaradayMiddleware::Instrumentation, {:name => 'tms_client'}
    ActiveSupport::Notifications.subscribe('tms_client') do |name, starts, ends, _, env|
      duration = ends - starts
      logger.info "#{env[:method].to_s.upcase.ljust(7)}#{env[:status].to_s.ljust(4)}#{env[:url]} (#{duration} seconds)"
      logger.debug('response headers') { JSON.pretty_generate env[:response_headers] }
      logger.debug('response body') { env[:body] }
    end
  end

  def dump_headers(headers)
    headers.map { |k, v| "#{k}: #{v.inspect}" }.join("\n")
  end
end
