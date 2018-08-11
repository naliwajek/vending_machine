describe Machine::Gateway::Change do
  %w(1p 2p 5p 10p 20p 50p 1gbp 2gbp).each do |coin|
    it "allows to add #{coin} change" do
      expect(subject.change[coin]).to eq(0)

      subject.add(coin)

      expect(subject.change[coin]).to eq(1)
    end

    it "allows to pay with #{coin} coin" do
      expect(subject.paid_in[coin]).to eq(0)

      subject.pay(coin)

      expect(subject.paid_in[coin]).to eq(1)
    end
  end

  it 'knows the total of paid in amount' do
    subject.pay('1p')
    subject.pay('2p')
    subject.pay('50p')
    subject.pay('1gbp')

    expect(subject.paid_in_total).to eq(1.53)
  end

  it 'throws exception when trying to add alien coins' do
    expect { subject.add('1eur') }.to raise_error(Machine::Errors::InvalidCoin)
  end

  it 'throws exception when trying to pay with alien coins' do
    expect { subject.pay('1eur') }.to raise_error(Machine::Errors::InvalidCoin)
  end
end