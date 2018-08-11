module Machine
  module Repository
    class Change
      @@paid_in_total = 0
      @@change = {
        '1p' => 0,
        '2p' => 0,
        '5p' => 0,
        '10p' => 0,
        '20p' => 0,
        '50p' => 0,
        '1gbp' => 0,
        '2gbp' => 0,
      }

      def self.change
        @@change
      end

      def self.add(coin)
        @@change[coin] += 1
      end

      def self.pay(coin)
        @@change[coin] += 1
        @@paid_in_total += denomination_to_float[coin]
      end

      def self.paid_in_total
        @@paid_in_total
      end

      def self.clear!
        @@paid_in_total = 0
        @@change = {
          '1p' => 0,
          '2p' => 0,
          '5p' => 0,
          '10p' => 0,
          '20p' => 0,
          '50p' => 0,
          '1gbp' => 0,
          '2gbp' => 0,
        }
      end

      def self.denomination_to_float
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
