module Machine
  module UseCase
    class ReturnProduct
      def initialize(product_gateway:)
        @product_gateway = product_gateway
      end

      def execute
      end

      private

      attr_reader :product_gateway
    end
  end
end