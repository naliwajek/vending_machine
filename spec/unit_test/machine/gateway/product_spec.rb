describe Machine::Gateway::Product do
  let(:products) { [ { name: 'Mars', price: 1.50 }, { name: 'Milkway', price: 1.0 }] }
  let(:load_products) { Staff::UseCase::LoadProducts.new(product_gateway: subject) }
  let(:select_product) { Buyer::UseCase::SelectProduct.new(product_gateway: subject) }

  it 'returns count of products' do
    load_products.execute(products: products)

    expect(subject.count).to eq(2)
  end

  it 'returns all the products' do
    load_products.execute(products: products)

    result = subject.products

    expect(result[0].name).to eq('Mars')
    expect(result[1].name).to eq('Milkway')
  end

  it 'allows to return product back to customer' do
    load_products.execute(products: products)
    select_product.execute(selected_product_id: 1)

    expect(subject.selected_product_idx).to eq(0)
    expect(subject.selected_product.name).to eq('Mars')

    subject.return_product

    expect(subject.selected_product_idx).to eq(nil)
    expect(subject.selected_product).to eq(nil)
  end

  it 'allows to select a product by non-zero index' do
    load_products.execute(products: products)

    subject.select_product(id: 1)

    expect(subject.selected_product_idx).to eq(0)
    expect(subject.selected_product.name).to eq('Mars')
  end

  it 'raises an error when non-zero index outside of count' do
    expect { subject.select_product(id: 1) }.to raise_error(Machine::Errors::NoSuchProduct)
  end
end