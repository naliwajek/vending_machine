describe Staff::UseCase::LoadProducts do
  let(:product_gateway) { Machine::Gateway::Product.new }
  let(:products) { [ { name: 'Mars', price: 1.50 }, { name: 'Milkway', price: 1.0 }] }
  subject { described_class.new(product_gateway: product_gateway).execute(products: products) }

  context 'loading set of products' do
    it 'responds with a loaded status' do
      expect(subject).to eq({ status: 'Products loaded'})
    end

    it 'puts each product in the machine' do
      subject
      expect(product_gateway.count).to eq(2)
    end
  end
end