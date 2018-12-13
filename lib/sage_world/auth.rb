module SageWorld
  class Auth

    attr_reader :request_body

    def initialize(params)
      validate_configuration
      @login_id   = SageWorld.configuration.login
      @password   = SageWorld.configuration.password
      @version    = SageWorld.configuration.version
      @account_id = SageWorld.configuration.account_id
      @params = params
    end

    def to_xml
      if request_body
        Gyoku.xml(request_body, key_converter: lambda { |key| key.camelize(:upper) })
      end
    end

    def request_body
      { XML_data_stream_request: body[:XML_data_stream_request].merge(@params) }
    end

    def body
      {
        XML_data_stream_request: {
          version: @version,
          auth: {
            acct_id: @account_id,
            login_id: @login_id,
            password: @password
          }
        }
      }
    end

    private def validate_configuration
      raise SageWorld::InvalidConfigurationError.new unless SageWorld.configuration.present?
    end

  end
end
