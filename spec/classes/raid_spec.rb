require 'spec_helper'

# Note, rspec-puppet determines the class name from the top level describe
# string.
describe 'raid' do
  describe "on RedHat" do
    let(:facts) do
      { :operatingsystem => 'RedHat' }
    end
    it { should contain_class 'raid' }
    it { should contain_class 'raid::repo' }
    it { should contain_class 'raid::package' }
    it { should contain_class 'raid::service' }
    it { should contain_class 'raid::nagios' }
    it { should_not contain_class 'raid::repo::debian' }
    it { should contain_notify 'Unsupported OS family: RedHat' }
  end

  describe "on Debian" do

    let(:facts) do
      { :operatingsystem => 'Debian' }
    end
    let :pre_condition do
      " define apt::source (
          $location          = '',
          $release           = $lsbdistcodename,
          $repos             = 'main',
          $include_src       = true,
          $required_packages = false,
          $key               = false,
          $key_server        = 'keyserver.ubuntu.com',
          $key_content       = false,
          $key_source        = false,
          $pin               = false
        ) {
          notify { 'mock apt::source $title':; }
        }
      "
    end

    it { should contain_class 'raid' }
    it { should contain_class 'raid::repo' }
    it { should contain_class 'raid::package' }
    it { should contain_class 'raid::service' }
    it { should contain_class 'raid::nagios' }
    it { should contain_class 'raid::repo::debian' }

    describe "No RAID Controller" do
        let(:facts) do
            { :raid_bus_controller_0_driver => nil }
            { :raid_bus_controller_0_device => nil }
            { :raid_bus_controller_0_vendor => nil }
        end
        it { should contain_notify 'No RAID Controller found' }
    end

  end
end
