require 'spec_helper'

describe 'raid::service' do

  describe 'without params set except the service itself' do
    let (:params) {
      { :service => 'foobar' }
    }
    it { should contain_service('foobar').with(
      :ensure => 'running',
      :enable => true )
    }
  end

  describe 'with raid_service set to false' do
    let (:params) {
      { 
        :service => 'foobar',
        :raid_service => false
      }
    }
    it { should contain_service('foobar').with(
      :ensure => 'stopped',
      :enable => false )
    }
  end
      
     
  describe "With Mail Checking set up" do

    let(:params) {
      {
        :raid_service => "true",
        :raid_mailto => "mommy",
        :raid_period => "123",
        :raid_remind => "456"
      }
    }

    it { should contain_augeas('set_defaults').with_changes(['set MAILTO mommy', 'set PERIOD 123', 'set REMIND 456']) }

  end

end
