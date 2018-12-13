require "sage_world/auth"
require "sage_world/client"
require "sage_world/constants"
require "sage_world/configuration"
require "sage_world/request"
require "sage_world/version"
Gem.find_files("sage_world/**/**/*.rb").each { |path| require path }
require "sage_world/response_handler"

module SageWorld

  class << self
    attr_accessor :configuration
  end

  def self.config
    @configuration ||= Configuration.new
    yield(configuration) if block_given?
  end

end
