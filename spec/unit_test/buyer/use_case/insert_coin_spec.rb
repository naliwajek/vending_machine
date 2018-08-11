describe Buyer::UseCase::InsertCoin do
  let(:change_gateway) { Machine::Gateway::Change.new }
  
  subject { described_class.new(change_gateway: change_gateway) }

  it 'returns status about paid in coins' do
    expect(subject.execute(coin: '1p')).to eq({ status: 'Inserted 1p coin' })
  end

  it 'stores paid in coins in the machine' do
    subject.execute(coin: '2p')
    subject.execute(coin: '2p')
    expect(change_gateway.paid_in_total).to eq(0.04)
  end
end
