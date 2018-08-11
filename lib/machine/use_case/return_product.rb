module Machine
  module UseCase
    class ReturnProduct
      def initialize(product_gateway:)
        @product_gateway = product_gateway
      end

      def execute
        if product_gateway.selected_product_idx.nil?
          raise Machine::Errors::NoProductSelected
        end

        product_gateway.return_product

        { status: 'Releasing product...' }
      end

      private

      attr_reader :product_gateway
    end
  end
end