module SageWorld
  module Api
    class SupplierList < SageWorld::Api::Base

      # Example Usage:
      #
      # response = SageWorld::Api::SupplierList.get()
        # response.as_hash => list as hash
        # response.as_xml => list as xml

      #
      # Options
      #
        # Sorting
        # Supplier list can be sorted by sageid, company or line
        # e.g response = SageWorld::Api::SupplierList.get({ sort: "sageid" })
        # sort by company response = SageWorld::Api::SupplierList.get({ sort: "company" })
        # sort by line response = SageWorld::Api::SupplierList.get({ sort: "line" })

      # AllLines => if set to 1 will return AllLines with every supplier
      # e.g response = SageWorld::Api::SupplierList.get({ alllines: 1 })
      #

      def self.get(params = {})
        if @existing_params == params
          @response
        else
          @existing_params = params
          response = SageWorld::Client.new(list_builder(params)).send_request
          @response = SageWorld::ResponseHandler.new(response)
        end
      end

      private_class_method def self.list_builder(params)
        {
          supplier_list: params
        }
      end

    end
  end
end
