module SageWorld
  class GeneralError < StandardError

    DEFAULT_MESSAGE = 'Error occured while fetching data.'

    def initialize(message = DEFAULT_MESSAGE)
      super
    end

  end
end
