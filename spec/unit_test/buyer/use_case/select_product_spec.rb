describe Buyer::UseCase::SelectProduct do
  let(:product_gateway) { Machine::Gateway::Product.new }
  let(:products) { [ { name: 'Mars', price: 1.50 }, { name: 'Milkway', price: 1.0 }] }
  let(:load_products) { Staff::UseCase::LoadProducts.new(product_gateway: product_gateway) }

  subject { described_class.new(product_gateway: product_gateway) }

  context 'selecting product within range' do
    it 'returns selected status' do
      load_products.execute(products: products)
     
      expect(subject.execute(selected_product_id: 1)).to \
        eq({ status: 'Selected product'})
    end
  end
end