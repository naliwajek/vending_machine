module Machine
  module Gateway
    class Change
      VALID_COINS = %w(1p 2p 5p 10p 20p 50p 1gbp 2gbp)

      def add(coin)
        raise Machine::Errors::InvalidCoin if !VALID_COINS.include?(coin)

        repository.add(coin)
      end

      def change
        repository.change
      end

      private

      def repository
        Machine::Repository::Change
      end
    end
  end
end