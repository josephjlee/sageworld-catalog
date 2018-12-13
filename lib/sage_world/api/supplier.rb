module SageWorld
  module Api
    class Supplier < SageWorld::Api::Base

      def initialize(supplier_id)
        @supplier_id = supplier_id
      end

      # Example Usage:
      #
      # supplier = SageWorld::Api::Supplier.new("222")
      # response = supplier.details
        # response.body => details as hash
      #
      #
      #  Options
        # ExtraReturnFields => specifies additional fields to be returned. If you would like to return the general information for a supplier,
        #                       then include GENINFO in this field. Otherwise leave it blank.
        #  supplier = SageWorld::Api::Supplier.new("22")
        #  e.g response = supplier.details({ extra_return_fields: "geninfo" })

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
