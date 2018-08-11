module Machine
  module UseCase
    class ListProducts
      def initialize(product_gateway:)
        @product_gateway = product_gateway
      end

      def execute(presenter:)
        presenter.present(product_gateway.products)
      end

      private

      attr_reader :product_gateway
    end
  end
end