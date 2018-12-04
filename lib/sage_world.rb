require "sage_world/version"

module SageWorld

  def self.configure
    @configuration = Sage::Configuration.new
    yield(@configuration) if block_given?
  end

end
