module Machine
  module Repository
    class Product
      @@products = []
      @@selected_product_idx = nil

      def self.products
        @@products
      end

      def self.selected_product_idx
        @@selected_product_idx
      end

      def self.set_selected_product(idx)
        @@selected_product_idx = idx
      end

      def self.add(product)
        @@products << product
      end

      def self.clear!
        @@products = []
        @@selected_product_idx = nil
      end
    end
  end
end