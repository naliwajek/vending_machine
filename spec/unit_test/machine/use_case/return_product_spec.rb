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
end