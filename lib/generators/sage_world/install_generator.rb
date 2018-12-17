module SageWorld
  module Generators
    class InstallGenerator < Rails::Generators::Base

      def create_initializer_file
        create_file "config/initializers/sage_world_initializer.rb", <<~FILE
          SageWorld.config do |config|
            config.account_id = ENV['sage_api_account']
            config.login = ENV['sage_api_login']
            config.password = ENV['sage_api_password']
            config.version = ENV['sage_api_version']
            config.end_point = ENV['sage_api_end_point']
          end
        FILE
      end

    end
  end
end
