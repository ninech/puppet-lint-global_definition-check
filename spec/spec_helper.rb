require 'puppet-lint'
require 'simplecov'
require 'simplecov-console'

PuppetLint::Plugins.load_spec_helper

SimpleCov.formatter = SimpleCov::Formatter::Console
SimpleCov.start do
  add_filter '/spec'
  add_filter '.bundle'
  add_filter '/vendor'
end
