module Machine
  module UseCase
    class ReturnChange
      def initialize(change_gateway:)
        @change_gateway = change_gateway
      end

      def execute(change_amount:)
        amount = change_gateway.get_change_back(change_amount)

        { status: "Change: #{'%.2f' % amount}" }
      end

      private

      attr_reader :change_gateway
    end
  end
end
