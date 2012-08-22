require 'spec_helper'

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
      {
        :operatingsystem => 'Debian',
        :lsbdistcodename => 'squeeze'
      }
    end

    it { should contain_class 'raid' }
    it { should contain_class 'raid::repo' }
    it { should contain_class 'raid::package' }
    it { should contain_class 'raid::service' }
    it { should contain_class 'raid::nagios' }
    it { should contain_class 'raid::repo::debian' }
    it { should contain_apt__source 'raid' }

    describe "No RAID Controller" do
        let(:facts) do
            { :raid_bus_controller_0_driver => nil }
            { :raid_bus_controller_0_device => nil }
            { :raid_bus_controller_0_vendor => nil }
        end
        it { should contain_notify 'No RAID Controller found' }
    end

    describe "With LSI Logic / Symbios Logic - LSI MegaSAS 9260 - megaraid_sas" do

      let(:facts) do
        {
          :raid_bus_controller_0_vendor => "LSI Logic / Symbios Logic",
          :raid_bus_controller_0_device => "LSI MegaSAS 9260",
          :raid_bus_controller_0_driver => "megaraid_sas"
        }
      end

      it { should contain_class 'raid::package::lsi' }
      it { should_not contain_notify 'No RAID Controller found' }
    end

  end
end
