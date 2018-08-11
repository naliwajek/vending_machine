module Machine
  module Gateway
    class Product
      def add(product_hash)
        product = Machine::Domain::Product.new
        product.name = product_hash[:name]
        product.price = product_hash[:price]

        repository.add(product)
      end

      def products
        repository.products
      end

      def count
        repository.products.count
      end

      def selected_product
        return nil if repository.selected_product_idx.nil?

        repository.products[repository.selected_product_idx]
      end

      def selected_product_idx
        repository.selected_product_idx
      end

      def select_product(id:)
        raise Machine::Errors::NoSuchProduct if id > count 

        repository.set_selected_product(id - 1)
      end

      def return_product
        repository.remove_product_at(repository.selected_product_idx)
        repository.clear_selected_product_idx!
      end

      private

      def repository
        Machine::Repository::Product
      end
    end
  end
end