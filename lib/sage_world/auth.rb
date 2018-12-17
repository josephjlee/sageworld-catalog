require 'gyoku'

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

    private def body
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
      check_configuration_presence
      check_end_point_presence
      check_credentials_presence
      check_account_presence
    end

    private def check_configuration_presence
      raise SageWorld::InvalidConfigurationError.new unless SageWorld.configuration.present?
    end

    private def check_end_point_presence
      raise SageWorld::InvalidConfigurationError.new(SageWorld::Constants::END_POINT_MISSING_ERROR) unless SageWorld.configuration.end_point
    end

    private def check_credentials_presence
      raise SageWorld::InvalidConfigurationError.new(SageWorld::Constants::INVALID_CREDENTIALS) unless SageWorld.configuration.login
      raise SageWorld::InvalidConfigurationError.new(SageWorld::Constants::INVALID_CREDENTIALS) unless SageWorld.configuration.password
    end

    private def check_account_presence
      raise SageWorld::InvalidConfigurationError.new(SageWorld::Constants::ACCOUNT_ID_MISSING_ERROR) unless SageWorld.configuration.account_id
    end

  end
end
