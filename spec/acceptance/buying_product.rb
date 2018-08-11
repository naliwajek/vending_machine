describe 'Buying product journey' do
  let(:change_array) { %w(1gbp 1gbp 1gbp 2gbp 50p 50p 50p 50p 20p 20p 20p 10p 10p 5p 1p 1p 1p 1p 1p) }
  let(:products) { [ { name: 'Mars', price: 1.50 }, { name: 'Milkway', price: 1.0 }] }

  let(:change_gateway) { Machine::Gateway::Change.new }
  let(:product_gateway) { Machine::Gateway::Product.new }
  let(:products_presenter_for_humans) { Buyer::Presenter::Products.new }

  let(:load_change_use_case) do 
    Staff::UseCase::LoadChange.new(
      change_gateway: change_gateway
    )
  end

  let(:load_products_use_case) do
    Staff::UseCase::LoadProducts.new(
      product_gateway: product_gateway
    )
  end

  let(:select_product_use_case) do
    Buyer::UseCase::SelectProduct.new(
      product_gateway: product_gateway
    )
  end

  let(:insert_coin_use_case) do
    Buyer::UseCase::InsertCoin.new(
      change_gateway: change_gateway
    )
  end

  let(:list_products_use_case) do
    Machine::UseCase::ListProducts.new(
      product_gateway: product_gateway
    )
  end

  let(:check_funds_use_case) do
    Machine::UseCase::CheckFunds.new(
     change_gateway: change_gateway,
     product_gateway: product_gateway
   )
  end

  it 'buys Mars' do
    load_change_use_case.execute(change_array: change_array)
    load_products_use_case.execute(products: products)
    select_product_use_case.execute(selected_product_id: 1)
    insert_coin_use_case.execute(coin: '1gbp')
    check_funds_use_case.execute
    insert_coin_use_case.execute(coin: '1gbp')
    result = check_funds_use_case.execute

    expect(result).to eq({ status: "Releasing product...\nChange: 0.50" })
  end
end