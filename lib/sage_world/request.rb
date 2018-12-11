require 'uri'
require 'net/http'

module SageWorld
  class Request

    attr_reader :url, :request, :body, :host, :port

    def initialize(params)
      @url ||= URI(SageWorld.configuration.end_point)
      @auth = SageWorld::Auth.new
      @params = params
    end

    def build_request
      @request = Net::HTTP::Post.new(@url.request_uri)
      body = @auth.body
      body[:XML_data_stream_request].merge!(@params)
      @request.body = Gyoku.xml(body, key_converter: lambda { |key| key.camelize(:upper) })
      @request
    end

    def http
      @http = Net::HTTP.new(host, port)
      @http.use_ssl = true
      @http
    end

    private def host
      @url.host
    end

    private def port
      @url.port
    end

  end
end
