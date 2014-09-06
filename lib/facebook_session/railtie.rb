require 'rails'

module PagesCore
  class Railtie < ::Rails::Railtie
    initializer :extend_rails do
      ActionView::Base.send :include, FacebookSession::Helper
      ActionController::Base.send :include, FacebookSession::Helper
    end
  end
end
