# I derived this from https://github.com/puppetlabs/puppetlabs-mysql.
require 'rspec/core/rake_task'
require 'puppetlabs_spec_helper/rake_tasks'
require 'rspec-system/rake_task'

# This is from the parent puppet-python repo.
require 'puppet-lint/tasks/puppet-lint'
PuppetLint.configuration.with_filename = true
PuppetLint.configuration.send('disable_documentation')
PuppetLint.configuration.send('disable_class_parameter_defaults')
PuppetLint.configuration.send('disable_80chars')

