module Machine
  module Repository
    class Product
      @@products = []

      def self.products
        @@products
      end

      def self.add(product)
        @@products << p
      end

      def self.clear!
        @@products = []
      end
    end
  end
end