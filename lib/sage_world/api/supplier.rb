module SageWorld
  module Api
    class Supplier < SageWorld::Api::Base

      def initialize(supplier_id)
        @supplier_id = supplier_id
      end

      def details(options = {})
        if @existing_options == options
          @response
        else
          @existing_options = options
          response = SageWorld::Client.new(find_supplier_params(@supplier_id, options)).send_request
          @response = SageWorld::ResponseHandler.new(response)
        end
      end

      private def find_supplier_params(supplier_id, options)
        {
          supplier_info: {
            supp_id: supplier_id
          }
        }.merge(options)
      end

    end
  end
end
