# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'facebook_session/version'

Gem::Specification.new do |s|
  s.name         = "facebook_session"
  s.version      = FacebookSession::VERSION
  s.authors      = ["Inge Jørgensen"]
  s.email        = "inge@manualdesign.no"
  s.homepage     = "https://github.com/manualdesign/simple_session"
  s.summary      = "Rails plugin for simple Facebook session authentication"
  s.description  = "Rails plugin for simple Facebook session authentication"

  s.files        = `git ls-files app lib`.split("\n")
  s.platform     = Gem::Platform::RUBY
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_path = 'lib'

  # specify any dependencies here; for example:
  #s.add_runtime_dependency "rake", ">= 0.8.7"
  #s.add_runtime_dependency "mysql", ">= 2.8.1"
end