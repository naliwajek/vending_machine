module Buyer
  module Presenter
    class Products
      def present(products)
        msg = "Select number to choose product\n"

        products.each_with_index do |p, idx|
          msg += "[#{idx}] #{p.name} for only #{p.price}!\n"
        end

        msg
      end
    end
  end
end