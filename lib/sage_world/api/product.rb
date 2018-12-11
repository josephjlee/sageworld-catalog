module SageWorld
  module Api
    class Product < SageWorld::Api::Base

      DEFAULT_SEARCH_PARAMS = {
        quick_search: ''
      }.freeze

      def initialize(product_id)
        @product_id = product_id
      end

      def details(options = {})
        response = SageWorld::Client.new(find_product_params(@product_id ,options)).send_request
        SageWorld::ResponseHandler.new(response)
      end

      def self.search(keyword, options = {})
        options[:quick_search] = keyword
        params = DEFAULT_SEARCH_PARAMS.merge(options)
        response = SageWorld::Client.new(search_product_params(params)).send_request
        SageWorld::ResponseHandler.new(response)
      end

      private def find_product_params(product_id, options)
        {
          product_detail: {
            product_id: product_id
          }
        }.merge(options)
      end

      private_class_method def self.search_product_params(params)
        {
          search: params
        }
      end

    end
  end
end
