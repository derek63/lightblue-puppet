require 'spec_helper'

describe 'lightblue::java' do

  context 'rhel6 x64 java default' do
    let :facts do
      {
        :osfamily => 'RedHat',
        :architecture => 'x86_64',
        :operatingsystemrelease => '6.0'
      }
    end
    
    it do
      should contain_package('java').with(
        {
          :ensure => 'latest'
        }
      )
      should contain_package('java-devel').with(
        {
          :ensure => 'latest'
        }
      )
    end
  end

  context 'rhel6 x64 java specific version' do
    let :facts do
      {
        :osfamily => 'RedHat',
        :architecture => 'x86_64',
        :operatingsystemrelease => '6.0'
      }
    end
    
    let :params do
      {
        :java_version => '1.8.0',
        :java_distribution => 'openjdk'
      }
    end

    it do
      should contain_package('java').with(
        {
          :ensure => 'latest'
        }
      )
      should contain_package('java-devel').with(
        {
          :ensure => 'latest'
        }
      )
    end
  end

  context 'rhel6 x64 java specific minor version' do
    let :facts do
      {
        :osfamily => 'RedHat',
        :architecture => 'x86_64',
        :operatingsystemrelease => '6.0'
      }
    end
    
    let :params do
      {
        :java_version => '1.8.0',
        :java_distribution => 'openjdk',
        :java_specific_version  =>'1.8.0.40-24.b25.fc21'
      }
    end

    it do
      should contain_package('java').with(
        {
          :ensure =>'java-1.8.0-openjdk-1.8.0.40-24.b25.fc21.x86_64'
        }
      )
      should contain_package('java-devel').with(
        {
          :ensure =>'java-1.8.0-openjdk-devel-1.8.0.40-24.b25.fc21.x86_64'
        }
      )
    end
  end

  context 'rhel7 x64 java default' do
    let :facts do
      {
        :osfamily => 'RedHat',
        :architecture => 'x86_64',
        :operatingsystemrelease => '7.0'
      }
    end
    
    it do
      should contain_package('java').with(
        {
          :ensure => 'latest'
        }
      )
      should contain_package('java-devel').with(
        {
          :ensure => 'latest'
        }
      )
    end
  end

  context 'rhel7 x64 java specific version' do
    let :facts do
      {
        :osfamily => 'RedHat',
        :architecture => 'x86_64',
        :operatingsystemrelease => '7.0'
      }
    end
    
    let :params do
      {
        :java_version => '1.8.0',
        :java_distribution => 'openjdk'
      }
    end

    it do
      should contain_package('java').with(
        {
          :ensure => 'latest'
        }
      )
      should contain_package('java-devel').with(
        {
          :ensure => 'latest'
        }
      )
    end
  end

  context 'rhel7 x64 java specific minor version' do
    let :facts do
      {
        :osfamily => 'RedHat',
        :architecture => 'x86_64',
        :operatingsystemrelease => '7.0'
      }
    end
    
    let :params do
      {
        :java_version => '1.8.0',
        :java_distribution => 'openjdk',
        :java_specific_version  =>'1.8.0.40-24.b25.fc21'
      }
    end

    it do
      should contain_package('java').with(
        {
          :ensure => 'java-1.8.0-openjdk-1.8.0.40-24.b25.fc21.x86_64'
        }
      )
      should contain_package('java-devel').with(
        {
          :ensure =>'java-1.8.0-openjdk-devel-1.8.0.40-24.b25.fc21.x86_64'
        }
      )
    end
  end

end
