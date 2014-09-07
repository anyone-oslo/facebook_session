# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'facebook_session/version'

Gem::Specification.new do |s|
  s.name         = "facebook_session"
  s.version      = FacebookSession::VERSION
  s.authors      = ["Inge Jørgensen"]
  s.email        = "inge@manualdesign.no"
  s.homepage     = "https://github.com/manualdesign/facebook_session"
  s.summary      = "Rails plugin for simple Facebook session authentication"
  s.description  = "Rails plugin for simple Facebook session authentication"

  s.files        = `git ls-files app lib`.split("\n")
  s.platform     = Gem::Platform::RUBY
  s.test_files   = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables  = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_path = 'lib'

  s.required_ruby_version = '>= 1.9.2'

  s.add_dependency "rails", ">= 3.0.0"
end