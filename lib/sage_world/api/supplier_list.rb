module SageWorld
  module Api
    class SupplierList < SageWorld::Api::Base

      def self.get(params = {})
        response = SageWorld::Client.new(list_builder(params)).send_request
        SageWorld::ResponseHandler.new(response)
      end

      def self.list_builder(params)
        {
          supplier_list: params
        }
      end

    end
  end
end
