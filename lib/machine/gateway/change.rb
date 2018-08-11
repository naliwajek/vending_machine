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
        repository.paid_in_total
      end

      def change
        repository.change
      end

      def get_change_back(amount_of_change)
        amount = 0

        VALID_COINS.reverse.each do |c|
          while change[c] > 0
            value = repository.denomination_to_float[c]
            break if amount + value > amount_of_change

            amount += value
            repository.remove(c)
          end

          next
        end
        
        amount
      end

      private

      def repository
        Machine::Repository::Change
      end
    end
  end
end
