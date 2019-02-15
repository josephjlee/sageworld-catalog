
require "sage_world/auth"
require "sage_world/client"
require "sage_world/constants"
require "sage_world/configuration"
require "sage_world/request"
require "sage_world/version"

require "sage_world/api/base"
require "sage_world/api/concerns/find_helper"

Gem.find_files("sage_world/**/*.rb").each { |path| puts path; require_relative path }

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
