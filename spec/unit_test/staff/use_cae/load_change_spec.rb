describe Staff::UseCase::LoadChange do
  let(:change_gateway) { Machine::Gateway::Change.new }
  let(:change_array) { %w(1p 1p 1p 2p 2p 5p 1gbp 2gbp) }
  subject { described_class.new(change_gateway: change_gateway).execute(change_array: change_array) }

  context 'loading set of coins' do
    it 'responds with a loaded status' do
      expect(subject).to eq({ status: 'Change loaded'})
    end

    it 'puts each coin as a change' do
      subject
      expect(change_gateway.change).to eq({
        "10p" => 0,
        "1gbp" => 1,
        "1p" => 3,
        "20p" => 0,
        "2gbp" => 1,
        "2p" => 2,
        "50p" => 0,
        "5p" => 1,
      })
    end
  end
end