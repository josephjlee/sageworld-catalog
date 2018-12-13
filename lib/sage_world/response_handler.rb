module SageWorld
  class ResponseHandler

    include SageWorld::Api::FindHelper

    attr_reader :response, :data_hash

    def initialize(response)
      validate_response(response)
      @response = response
    end

    def body
      @response.body.with_indifferent_access
    end

    private def validate_response(response)
      if response.body['XMLDataStreamResponse'].key?('ErrMsg')
        raise SageWorld::GeneralError.new(response.body['XMLDataStreamResponse']['ErrMsg'])
      end
    end

  end
end
