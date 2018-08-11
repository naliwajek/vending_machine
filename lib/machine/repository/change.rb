module Machine
  module Repository
    class Change
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

      @@paid_in = {
        '1p' => 0,
        '2p' => 0,
        '5p' => 0,
        '10p' => 0,
        '20p' => 0,
        '50p' => 0,
        '1gp' => 0,
        '2gp' => 0,
      }

      def self.change
        @@change
      end

      def self.paid_in
        @@paid_in
      end

      def self.add(coin)
        @@change[coin] += 1
      end

      def self.pay(coin)
        @@paid_in[coin] += 1
      end

      def self.clear!
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

        @@paid_in = {
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
    end
  end
end
