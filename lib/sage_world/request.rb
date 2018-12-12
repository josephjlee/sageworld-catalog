require 'uri'
require 'net/http'
require 'gyoku'

module SageWorld
  class Request

    attr_reader :url, :request, :body, :host, :port

    def initialize(params)
      @params = params
      @auth = SageWorld::Auth.new
      @url ||= URI(SageWorld.configuration.end_point)
    end

    def build_request
      @request = Net::HTTP::Post.new(@url.request_uri)
      @request.body = Gyoku.xml(xml_request_params, key_converter: lambda { |key| key.camelize(:upper) })
      @request
    end

    def http
      @http = Net::HTTP.new(host, port)
      @http.use_ssl = true || SageWorld.configuration.use_ssl
      @http
    end

    private def xml_request_params
      body = @auth.body
      body[:XML_data_stream_request].merge!(@params)
      body
    end

    private def host
      @url.host
    end

    private def port
      @url.port
    end

  end
end
