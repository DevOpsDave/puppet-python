# spec/classes/init_spec.rb

require 'spec_helper'

describe "python", :type => :class do
  let(:facts) { {:operatingsystem => 'RedHat'} }

  it { should include_class('python::install') and should include_class('python::config')}
  #it { should include_class('python::config') }

end