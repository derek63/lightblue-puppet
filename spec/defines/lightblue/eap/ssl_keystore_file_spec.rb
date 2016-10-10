require 'spec_helper'

describe 'lightblue::eap::ssl_keystore_file' do

  let(:hiera_config){ 'spec/fixtures/hiera/hiera.yaml' }

  let :facts do
    {
      :architecture => 'x86_64'
    }
  end

  context 'defaults' do

    let :params do
      {
        :name   => 'lightblue.io',
        :source => 'puppet:///modules/certificates/lightblue.io',
        :file   => '/lightblue.io'
      }
    end

    it do
      #should contain_file("/lightblue.io")
      #should contain_file("/keystore/eap6.keystore")
    end
  end

end
