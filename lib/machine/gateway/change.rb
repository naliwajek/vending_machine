module Machine
  module Gateway
    class Change
      VALID_COINS = %w(1p 2p 5p 10p 20p 50p 1gbp 2gbp)

      def add(coin)
        raise Machine::Errors::InvalidCoin if !VALID_COINS.include?(coin)

        repository.add(coin)
      end

      def pay(coin)
        raise Machine::Errors::InvalidCoin if !VALID_COINS.include?(coin)

        repository.pay(coin)
      end

      def paid_in_total
        sum = 0

        paid_in.each do |k, v|
          sum += denomination_to_float[k] * v
        end
        
        sum
      end

      def change
        repository.change
      end

      def paid_in
        repository.paid_in
      end

      private

      def repository
        Machine::Repository::Change
      end

      def denomination_to_float
        {
          '1p' => 0.01,
          '2p' => 0.02,
          '5p' => 0.05,
          '10p' => 0.10,
          '20p' => 0.20,
          '50p' => 0.50,
          '1gbp' => 1.0,
          '2gbp' => 2.0
        }
      end
    end
  end
end
