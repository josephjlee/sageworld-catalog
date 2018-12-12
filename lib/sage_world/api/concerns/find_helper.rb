module SageWorld
  module Api
    module FindHelper

      module InstanceMethods

        def find_in_hash(lookup_key, haystack = as_hash)
          if haystack.respond_to?(:key?) && haystack.key?(lookup_key)
            haystack[lookup_key]
          elsif haystack.respond_to?(:each)
            data = nil
            haystack.find{ |*nested_haystack| data = find_in_hash(lookup_key, nested_haystack.last) }
            data
          end
        end

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

