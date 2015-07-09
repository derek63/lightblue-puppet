require 'spec_helper'

describe 'lightblue::eap::logging' do

  let(:hiera_config){ 'spec/fixtures/hiera/hiera.yaml' }

  let :facts do
    {
      :architecture => 'x86_64'
    }
  end

  context 'defaults' do
    it do
      should contain_file("/jcliff/logging.conf")
      should contain_file("/jcliff/authlogging.conf")
    end
  end

end
