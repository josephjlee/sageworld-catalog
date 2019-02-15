module SageWorld
  class ResponseHandler
    include SageWorld::Api::FindHelper

    attr_reader :response

    def initialize(response)
      validate_response(response)
      @response = response
    end

    def body
      @response.body.with_indifferent_access
    end

    def method_missing(method_name)
      key_name = method_name.to_s.camelize
      find_in_hash(key_name)
    end

    private def validate_response(response)
      if response.body[SageWorld::Constants::ROOT_KEY].key?(SageWorld::Constants::ERROR_KEY)
        raise SageWorld::GeneralError.new(response.body[SageWorld::Constants::ROOT_KEY][SageWorld::Constants::ERROR_KEY])
      end
    end

  end
end
