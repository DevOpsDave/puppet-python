# I derived this from https://github.com/puppetlabs/puppetlabs-mysql.
dir = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift File.join(dir, 'lib')

require 'rubygems'
require 'simplecov'
require 'rspec-puppet'
require 'puppetlabs_spec_helper/module_spec_helper'
require 'pathname'
require 'tmpdir'

fixture_path = File.expand_path(File.join(__FILE__, '..', 'fixtures'))

RSpec.configure do |config|
  config.tty = true
  config.mock_with :rspec do |c|
    c.syntax = :expect
  end
  config.module_path = File.join(fixture_path, 'modules')
  config.manifest_dir = File.join(fixture_path, 'manifests')
end
