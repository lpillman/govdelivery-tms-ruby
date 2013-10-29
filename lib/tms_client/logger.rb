module TMS #:nodoc:
  class Logger < Faraday::Response::Middleware #:nodoc:
    extend Forwardable

    def initialize(app, logger = nil)
      super(app)
      @logger = logger || begin
        require 'logger'
        ::Logger.new(STDOUT)
      end
    end

    def_delegators :@logger, :debug, :info, :warn, :error, :fatal

    def call(env)
      debug "performing #{env[:method].to_s.upcase.ljust(7)} #{env[:url]}"
      super
    end


  end
end