module SageWorld
  class Client

    attr_reader :auth

    def initialize(builder)
      @auth ||= SageWorld::Auth.new
      @request = SageWorld::Request.new(builder)
    end

    def send_request
      response = http.request(@request.build_request)
    end

    private def http
      @request.http
    end

  end
end
