# I derived this from https://github.com/puppetlabs/puppetlabs-mysql.

require 'rspec-system/spec_helper'
require 'rspec-system-puppet/helpers'
require 'rspec-system-serverspec/helpers'

include RSpecSystemPuppet::Helpers

include Serverspec::Helper::RSpecSystem
include Serverspec::Helper::DetectOS

