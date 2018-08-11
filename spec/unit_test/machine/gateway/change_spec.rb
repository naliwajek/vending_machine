describe Machine::Gateway::Change do
  %w(1p 2p 5p 10p 20p 50p 1gbp 2gbp).each do |coin|
    it "allows to add #{coin} change" do
      expect(subject.change[coin]).to eq(0)

      subject.add(coin)

      expect(subject.change[coin]).to eq(1)
    end

    it "allows to pay with #{coin} coin" do
      expect(subject.change[coin]).to eq(0)

      subject.pay(coin)

      expect(subject.change[coin]).to eq(1)
    end
  end

  context 'when getting change' do
    it 'returns nothing if empty' do
      result = subject.get_change_back(0.1)
      expect(result).to eq(0.0)
    end

    it 'returns even small amounts' do
      subject.pay('5p')
      subject.pay('5p')
      expect(subject.change['5p']).to eq(2)

      result = subject.get_change_back(0.1)
      expect(result).to eq(0.1)

      expect(subject.change['5p']).to eq(0)
    end

    it 'returns when multiple coins must be combined' do
      subject.pay('50p')
      subject.pay('20p')
      subject.pay('5p')
      subject.pay('1p')
      expect(subject.change['50p']).to eq(1)
      expect(subject.change['20p']).to eq(1)
      expect(subject.change['5p']).to eq(1)
      expect(subject.change['1p']).to eq(1)

      result = subject.get_change_back(0.26)
      expect(result).to eq(0.26)

      expect(subject.change['50p']).to eq(1)
      expect(subject.change['20p']).to eq(0)
      expect(subject.change['5p']).to eq(0)
      expect(subject.change['1p']).to eq(0)
    end

    it 'returns nearest amount when possible' do
      subject.pay('50p')
      subject.pay('20p')
      subject.pay('5p')
      subject.pay('1p')
      expect(subject.change['50p']).to eq(1)
      expect(subject.change['20p']).to eq(1)
      expect(subject.change['5p']).to eq(1)
      expect(subject.change['1p']).to eq(1)

      result = subject.get_change_back(0.29)
      expect(result).to eq(0.26)

      expect(subject.change['50p']).to eq(1)
      expect(subject.change['20p']).to eq(0)
      expect(subject.change['5p']).to eq(0)
      expect(subject.change['1p']).to eq(0)
    end

    it 'works between small and large coins' do
      subject.pay('50p')
      subject.pay('20p')
      subject.pay('5p')
      subject.pay('1gbp')
      subject.pay('1gbp')
      expect(subject.change['50p']).to eq(1)
      expect(subject.change['20p']).to eq(1)
      expect(subject.change['5p']).to eq(1)
      expect(subject.change['1gbp']).to eq(2)

      result = subject.get_change_back(2.29)
      expect(result).to eq(2.25)

      expect(subject.change['50p']).to eq(1)
      expect(subject.change['20p']).to eq(0)
      expect(subject.change['5p']).to eq(0)
      expect(subject.change['1gbp']).to eq(0)
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