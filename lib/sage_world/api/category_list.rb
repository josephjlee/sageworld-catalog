module SageWorld
  module Api
    class CategoryList < SageWorld::Api::Base

      def self.get(params = {})
        response = SageWorld::Client.new(list_builder(params)).send_request
        SageWorld::ResponseHandler.new(response)
      end

      private_class_method def self.list_builder(params)
        {
          category_list: params
        }
      end

    end
  end
end
