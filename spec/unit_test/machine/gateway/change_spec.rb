describe Machine::Gateway::Change do
  %w(1p 2p 5p 10p 20p 50p 1gbp 2gbp).each do |coin|
    it "allows to add #{coin} change" do
      expect(subject.change[coin]).to eq(0)

      subject.add(coin)

      expect(subject.change[coin]).to eq(1)
    end
  end

  it 'throws exception when trying to add alien coins' do
    expect { subject.add('1eur') }.to raise_error(Machine::Errors::InvalidCoin)
  end
end