module SageWorld
  module Api
    class CategoryList < SageWorld::Api::Base

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
          category_list: params
        }
      end

    end
  end
end
