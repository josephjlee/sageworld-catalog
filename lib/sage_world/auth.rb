module SageWorld
  class Auth

    def initialize
      validate_configuration
      @login_id   = SageWorld.configuration.login
      @password   = SageWorld.configuration.password
      @version    = SageWorld.configuration.version
      @account_id = SageWorld.configuration.account_id
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
