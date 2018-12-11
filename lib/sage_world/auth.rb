module SageWorld
  class Auth

    def initialize(options= {})
      @login_id   = SageWorld.configuration.login      || options[:login]
      @password   = SageWorld.configuration.password   || password[:password]
      @version    = SageWorld.configuration.version    || version[:version]
      @account_id = SageWorld.configuration.account_id || acct_id[:version]
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

  end
end
