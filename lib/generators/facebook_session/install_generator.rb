module FacebookSession
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path '../templates', __FILE__

      desc "Create facebook_session config and prepare application.js"

      def create_initializer
        template 'initializer.rb', File.join('config', 'initializers', 'facebook_session.rb')
      end


      def inject_js
        require_js = "//= require facebook_session\n"

        if manifest.exist?
          manifest_contents = File.read(manifest)

          if manifest_contents.include? 'require_tree'
            inject_into_file manifest, require_js, {before: '//= require_tree'}
          else
            append_file manifest, require_js
          end
        else
          create_file manifest, require_js
        end
      end

      private

      def manifest
        Pathname.new(destination_root).join('app/assets/javascripts', 'application.js')
      end
    end
  end
end
