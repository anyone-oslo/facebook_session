require 'rails'

module PagesCore
  class Engine < ::Rails::Engine
    initializer :extend_rails do
      ActionView::Base.send :include, FacebookSession::Helper
      ActionController::Base.send :include, FacebookSession::Helper
    end
  end
end
