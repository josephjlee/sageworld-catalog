require 'nori'
require 'nokogiri'

module SageWorld
  class ResponseHandler

    attr_reader :response

    def initialize(response)
      @response = response
    end

    def code
      @response.code
    end

    def message
      @response.message
    end

    def error_message
      as_hash[SageWorld::Constants::ROOT_KEY][:err_msg]
    end

    def header
      @response.header
    end

    def as_xml
      Nokogiri::XML(@response.body)
    end

    def as_hash
      parser = Nori.new(:convert_tags_to => lambda { |tag| tag.snakecase.to_sym })
      parser.parse(@response.body)
    end

  end
end
