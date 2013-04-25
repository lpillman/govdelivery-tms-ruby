# The client class to connect and talk to the TMS REST API.
class TMS::Client
  include TMS::Util::HalLinkParser
  include TMS::CoreExt

  attr_accessor :connection, :href

  DEFAULTS = {:api_root => 'http://localhost:3000', :logger => nil}.freeze

  # Create a new client and issue a request for the available resources for a given account.
  #
  # @param [String] username The username of your account
  # @param [String] password The password of your account
  # @param [Hash] options
  # @option options [String] :api_root The root URL of the TMS api. Defaults to localhost:3000
  # @option options [Logger] :logger An instance of a Logger class (http transport information will be logged here) - defaults to nil
  #
  # @example
  #   client = TMS::Client.new("foo@example.com", "onetwothree", {
  #                               :api_root => "https://tms.govdelivery.com",
  #                               :logger => Logger.new(STDOUT)})
  #
  def initialize(username, password, options = DEFAULTS)
    @api_root = options[:api_root]
    connect!(username, password, options[:logger])
    discover!
  end

  def connect!(username, password, logger)
    self.connection = TMS::Connection.new(:username => username, :password => password, :api_root => @api_root, :logger => logger)
  end

  def discover!
    services = get('/').body
    parse_links(services['_links'])
  end

  def get(href)
    response = raw_connection.get(href)
    case response.status
    when 401..499
      raise TMS::Request::Error.new(response.status)
    when 202
      raise TMS::Request::InProgress.new(response.body['message'])
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
      raise TMS::Request::Error.new(response.status)
    end
  end

  def raw_connection
    connection.connection
  end

  def client
    self
  end

end
