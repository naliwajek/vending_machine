module Machine
  module UseCase
    class CheckFunds
      def initialize(change_gateway:, product_gateway:)
        @change_gateway = change_gateway
        @product_gateway = product_gateway
      end

      def execute
        paid_in = change_gateway.paid_in_total
        price = product_gateway.selected_product.price

        if paid_in >= price
          Machine::UseCase::ReturnProduct.new(product_gateway: product_gateway).execute
        else
          { status: "Waiting for #{'%.2f' % (paid_in - price).abs}"}
        end
      end

      private

      attr_reader :change_gateway, :product_gateway
    end
  end
end