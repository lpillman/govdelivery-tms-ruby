module TSMS
  module Request
    class Error < StandardError
      attr_reader :code

      def initialize(code)
        super("HTTP Error: #{code}")
        @code=code
      end
    end
    class InProgress < StandardError
    end
  end
end