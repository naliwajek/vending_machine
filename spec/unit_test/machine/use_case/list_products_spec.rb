describe Machine::UseCase::ListProducts do
  let(:product_gateway) { Machine::Gateway::Product.new }
  let(:products) { [ { name: 'Mars', price: 1.50 }, { name: 'Milkway', price: 1.0 }] }
  let(:load_products) { Staff::UseCase::LoadProducts.new(product_gateway: product_gateway) }

  context 'when presenting to humans' do
    let(:presenter) { Buyer::Presenter::Products.new }

    it 'returns readable list of products' do
      load_products.execute(products: products)
      result = described_class.new(product_gateway: product_gateway).execute(presenter: presenter)

      expect(result).to eq("Select number to choose product\n[0] Mars for only 1.5!\n[1] Milkway for only 1.0!\n")
    end
  end
end