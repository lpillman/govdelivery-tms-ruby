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
      faraday.headers['X-AUTH-TOKEN'] = auth_token
      faraday.headers[:user_agent] = "GovDelivery Ruby TMS::Client #{TMS::VERSION}"
      faraday.response :json, :content_type => /\bjson$/
      faraday.adapter :net_http
    end
  end

  def dump_headers(headers)
    headers.map { |k, v| "#{k}: #{v.inspect}" }.join("\n")
  end
end
