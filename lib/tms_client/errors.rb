module TMS
  module Errors
    class InvalidGet < StandardError
      def initialize(message=nil)
        super(message || "Can't GET a resource after an invalid POST; either create a new object or fix errors")
      end
    end
  end
end