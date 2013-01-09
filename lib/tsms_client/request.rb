module TSMS #:nodoc:
  module Request
    # The generic TSMS error class
    class Error < StandardError
      attr_reader :code

      def initialize(code)
        super("HTTP Error: #{code}")
        @code=code
      end
    end

    # Raised when a recipient list is still being constructed and a request is made to view the 
    # recipient list for a message.
    class InProgress < StandardError; end
  end
end