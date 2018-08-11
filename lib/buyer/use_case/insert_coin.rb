module Buyer
  module UseCase
    class InsertCoin
      def initialize(change_gateway:)
        @change_gateway = change_gateway
      end

      def execute(coin:)
        change_gateway.pay(coin)

        { status: "Inserted #{coin} coin" }
      end

      private

      attr_reader :change_gateway
    end
  end
end