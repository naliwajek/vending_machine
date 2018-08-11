module Buyer
  module UseCase
    class SelectProduct
      def initialize(product_gateway:)
        @product_gateway = product_gateway
      end

      def execute(selected_product_id:)
        product_gateway.select_product(id: selected_product_id)

        { status: "Selected product" }
      end

      private

      attr_reader :product_gateway
    end
  end
end