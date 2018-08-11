describe Machine::UseCase::ReturnChange do
  let(:change_gateway) { Machine::Gateway::Change.new }
  let(:insert_coin) { Buyer::UseCase::InsertCoin.new(change_gateway: change_gateway) }

  subject do
    described_class.new(
      change_gateway: change_gateway,
    )
  end

  it 'returns a change' do
    insert_coin.execute(coin: '1gbp')
    insert_coin.execute(coin: '50p')
    insert_coin.execute(coin: '5p')
    insert_coin.execute(coin: '5p')

    expect(subject.execute(change_amount: 0.1)).to eq({ status: 'Change: 0.10'})
  end
end