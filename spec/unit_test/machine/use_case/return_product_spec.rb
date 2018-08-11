describe Machine::UseCase::ReturnProduct do
  let(:product_gateway) { Machine::Gateway::Product.new }

  let(:products) { [ { name: 'Mars', price: 1.50 }, { name: 'Milkway', price: 1.0 }] }
  let(:load_products) { Staff::UseCase::LoadProducts.new(product_gateway: product_gateway) }
  let(:select_product) { Buyer::UseCase::SelectProduct.new(product_gateway: product_gateway) }

  subject do
    described_class.new(
      product_gateway: product_gateway
    )
  end

  context 'when no product selected' do
    it 'throws an error' do
      expect { subject.execute }.to raise_error(Machine::Errors::NoProductSelected)
    end
  end

  context 'when product is selected' do
    it 'returns releasing status' do
      load_products.execute(products: products)
      select_product.execute(selected_product_id: 1)

      expect(subject.execute).to eq({ status: 'Releasing product...' })
    end
  end
end