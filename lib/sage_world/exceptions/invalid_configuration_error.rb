module SageWorld
  class InvalidConfigurationError < StandardError

    INVALID_CONFIGURATION = 'SageWorld configuration not found.'.freeze

    def initialize(message = INVALID_CONFIGURATION)
      super
    end

  end
end
