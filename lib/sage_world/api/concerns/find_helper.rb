module SageWorld
  module Api
    module FindHelper

      module InstanceMethods
        # SageWorld Api provides helper method on SageWorld::ResponseHandler
        # which can return the key in nested hash or array and return its value.
        #
        # e.g response = SageWorld::Api::Product.search("mugs")
        # Find in hash provides an easy way to do
        # response.as_hash[:xml_data_stream_response][:search_results][:items][:item] => simplifies to
        # response.find_in_hash(:item) => returns array of items.

        # Similarly, for product
        # product = SageWorld::Api::Product.new("id")
        # response = product.details.as_hash
        # {
        #   xml_data_stream_response: {
        #     product_details: { .. }
        #   }
        # }
        #
        def find_in_hash(lookup_key, haystack = as_hash)
          if haystack.respond_to?(:key?) && haystack.key?(lookup_key)
            haystack[lookup_key]
          elsif haystack.respond_to?(:each)
            data = nil
            haystack.find{ |*nested_haystack| data = find_in_hash(lookup_key, nested_haystack.last) }
            data
          end
        end
        # Finding in Xml
        # response.find_in_xml("Item") => Array of items or nil.
        def find_in_xml(lookup_key, haystack = as_xml)
          haystack.xpath("//#{lookup_key}")
        end

      end

      def self.included(klass)
        klass.send(:include, InstanceMethods)
      end
    end
  end
end

