require "sage_world/auth"
require "sage_world/client"
require "sage_world/constants"
require "sage_world/configuration"
require "sage_world/request"
require "sage_world/version"
require "sage_world/response_handler"
Gem.find_files("sage_world/api/**/*.rb").each { |path| require path }

module SageWorld

  class << self
    attr_accessor :configuration
  end

  def self.config
    @configuration ||= Configuration.new
    yield(configuration) if block_given?
  end

end
