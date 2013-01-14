# The client class to connect and talk to the TSMS REST API. 
class TSMS::Client
  include TSMS::Util::HalLinkParser
  include TSMS::CoreExt

  attr_accessor :connection, :href

  # Create a new client and issue a request for the available resources for a given account. 
  #
  # === Options
  # * +:api_root+ - The root URL of the TSMS api. Defaults to localhost:3000
  # * +:logger+   - An instance of a Logger class (http transport information will be logged here) - defaults to nil
  #
  # === Examples
  #   client = TSMS::Client.new("foo@example.com", "onetwothree", {
  #                               :api_root => "https://tsms.govdelivery.com", 
  #                               :logger => Logger.new(STDOUT)})
  # 
  def initialize(username, password, options = {:api_root => 'http://localhost:3000', :logger => nil})
    @api_root = options[:api_root]
    connect!(username, password, options[:logger])
    discover!
  end

  def connect!(username, password, logger)
    self.connection = TSMS::Connection.new(:username => username, :password => password, :api_root => @api_root, :logger => logger)
  end

  def discover!
    services = get('/').body
    parse_links(services['_links'])
  end

  def get(href)
    response = raw_connection.get(href)
    case response.status
      when 401..499
        raise TSMS::Request::Error.new(response.status)
      when 202
        raise TSMS::Request::InProgress.new(response.body['message'])
      else
        return response
    end
  end

  def post(obj)
    raw_connection.post do |req|
      req.url @api_root + obj.href
      req.headers['Content-Type'] = 'application/json'
      req.body = obj.to_json
    end
  end

  def put(obj)
    raw_connection.put do |req|
      req.url @api_root + obj.href
      req.headers['Content-Type'] = 'application/json'
      req.body = obj.to_json
    end
  end

  def delete(href)
    response = raw_connection.delete(href)
    case response.status
      when 200
        return response
      else
        raise TSMS::Request::Error.new(response.status)
    end
  end

  def raw_connection
    connection.connection
  end

  def client
    self
  end

end