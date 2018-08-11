module Machine
  module Gateway
    class Product
      def add(product_hash)
        product = Machine::Domain::Product.new
        product.name = product_hash[:name]
        product.price = product_hash[:price]

        repository.add(product)
      end

      def count
        repository.products.count
      end

      private

      def repository
        Machine::Repository::Product
      end
    end
  end
end