module SageWorld
  module Api
    class ProductThemeList < SageWorld::Api::Base

    # Usage:

    # response = SageWorld::Api::ProductThemeList.get => return SageWorld::ResponseHandler object.

    # On SageWorld::ResponseHandler object one can call following methods depending upon requirements.
      # response.as_hash => returns the response in hash format.
      # response.as_xml => returns the response in xml format.

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
          theme_list: params
        }
      end

    end
  end
end
