module Staff
  module UseCase
    class LoadChange
      def initialize(change_gateway:)
        @change_gateway = change_gateway
      end

      def execute(change_array:)
        change_array.each do |change|
          change_gateway.add(change)
        end

        { status: 'Change loaded' }
      end

      private

      attr_reader :change_gateway
    end
  end
end