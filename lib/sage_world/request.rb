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
      @connection ||= Faraday.new(@url) do |builder|

        builder.response :xml, :content_type => /\bxml$/

        builder.response :json, :content_type => /\bjson$/

        builder.response :xml, :content_type => /\bhtml$/

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
