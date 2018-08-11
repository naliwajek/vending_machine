describe Machine::UseCase::CheckFunds do
  let(:product_gateway) { Machine::Gateway::Product.new }
  let(:change_gateway) { Machine::Gateway::Change.new }

  let(:products) { [ { name: 'Mars', price: 1.50 }, { name: 'Milkway', price: 1.0 }] }
  let(:load_products) { Staff::UseCase::LoadProducts.new(product_gateway: product_gateway) }
  let(:insert_coin) { Buyer::UseCase::InsertCoin.new(change_gateway: change_gateway) }
  let(:select_product) { Buyer::UseCase::SelectProduct.new(product_gateway: product_gateway) }

  subject do
    described_class.new(
      change_gateway: change_gateway,
      product_gateway: product_gateway
    )
  end

  context 'when nothing was paid in' do
    it 'returns the whole value of the product you have to pay' do
      load_products.execute(products: products)
      select_product.execute(selected_product_id: 1)

      expect(subject.execute).to eq({ status: 'Waiting for 1.50'})
    end
  end

  context 'when part was paid in' do
    it 'returns the missing value of the product you still have to pay' do
      load_products.execute(products: products)
      select_product.execute(selected_product_id: 1)
      insert_coin.execute(coin: '1gbp')

      expect(subject.execute).to eq({ status: 'Waiting for 0.50'})
    end
  end

  context 'when all or more was paid in' do
    it 'delegates responisiblity for returning a product' do
      load_products.execute(products: products)
      select_product.execute(selected_product_id: 1)
      insert_coin.execute(coin: '1gbp')
      insert_coin.execute(coin: '1gbp')

      expect_any_instance_of(Machine::UseCase::ReturnProduct).to receive(:execute)

      subject.execute
    end
  end
end