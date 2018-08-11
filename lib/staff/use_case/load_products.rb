module Staff
  module UseCase
    class LoadProducts
      def initialize(product_gateway:)
        @product_gateway = product_gateway
      end

      def execute(products:)
        products.each do |product|
          product_gateway.add(product)
        end

        { status: 'Products loaded' }
      end

      private

      attr_reader :product_gateway
    end
  end
end