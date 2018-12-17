module SageWorld
  module Generators
    class InstallGenerator < Rails::Generators::Base

      def create_initializer_file
        create_file "config/initializers/sage_world_initializer.rb", <<~FILE
          SageWorld.config do |config|
            # Sage Account ID
            config.account_id = ENV['sage_api_account']
            # Sage Login
            config.login = ENV['sage_api_login']
            # Sage Password
            config.password = ENV['sage_api_password']
            # Sage Api Version
            config.version = ENV['sage_api_version']
            # Sage End Point
            config.end_point = ENV['sage_api_end_point']
            # Optional Logging
            config.log_data = true # logs request response to log/sage_world.log
          end
        FILE
      end

    end
  end
end
