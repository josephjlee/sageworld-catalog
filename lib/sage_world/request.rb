require 'faraday'
require 'faraday_middleware'

module SageWorld
  class Request

    attr_reader :url, :connection

    def initialize(params)
      @params = params
      @auth ||= SageWorld::Auth.new(params)
      @url ||= URI(SageWorld.configuration.end_point)
    end

    private def make_connection
      @connection ||= Faraday.new(@url, { request: { timeout: 3000 } }) do |builder|

        builder.response :xml, :content_type => /\bxml$/

        builder.response :json, :content_type => /\bjson$/

        builder.response :xml, :content_type => /\bhtml$/

        # Enable logging if enabled
        if SageWorld.configuration.log_data
          builder.response :logger, ::Logger.new("#{Rails.root}/log/sage_world.log"), bodies: true do |logger|
            logger.filter(/(\<LoginId\>)(\w+)/,'\1[REMOVED]')
            logger.filter(/(\<Password\>)(\w+)/,'\1[REMOVED]')
            logger.filter(/(\<AcctId\>)(\w+)/,'\1[REMOVED]')
          end
        end

        builder.adapter Faraday.default_adapter
      end
    end

    def make_request
      @connection ||= make_connection

      if @connection
        @connection.post do |request|
          request.body = @auth.to_xml
        end
      end
    end

  end
end
