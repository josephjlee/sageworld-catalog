module SageWorld
  module Api
    class CategoryList < SageWorld::Api::Base
    # Usage:

    # Without params:

      # response = SageWorld::Api::CategoryList.get => return SageWorld::ResponseHandler object.
      # On SageWorld::ResponseHandler object one can call following methods depending upon requirements.
        # response.body => returns the response in hash format.

    # With params:

      # Sorting results
      # Category list can be sorted by Category Name or Category Number.
      # By Default Category list is sorted by Name.
      # response = SageWorld::Api::CategoryList.get({ sort: "name"}) => sorts category list by name
      # response = SageWorld::Api::CategoryList.get({ sort: "catnum"}) => sorts category list by category number

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
