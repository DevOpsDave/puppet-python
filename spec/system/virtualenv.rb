require 'spec_helper_system'

describe 'virtualenv' do

  describe 'create new env' do
    it 'should work with no errors.' do
      pp = <<-EOS
        virtualenv { '/tmp/blah': }
      EOS

      puppet_apply(pp)
    end
  end

end