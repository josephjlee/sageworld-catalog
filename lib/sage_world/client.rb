module SageWorld
  class Client

    def initialize(builder)
      @request = SageWorld::Request.new(builder)
    end

    def send_request
      @request.make_request
    end

    private def http
      @request.http
    end

  end
end
