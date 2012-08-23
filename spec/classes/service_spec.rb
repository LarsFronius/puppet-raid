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

  describe "With Mail Checking set up to send mails to dummy" do

    let(:params) {
      {
        :raid_service => "true",
        :raid_mailto  => "dummy",
      }
    }

    it { should contain_augeas('set_default_mailto').with_changes('set MAILTO dummy') }
    it { should_not contain_augeas('set_default_period') }
    it { should_not contain_augeas('set_default_remind') }

  end

  describe "With Mail Checking set up to send mails to dummy with specific period and remind" do
    let(:params) {
      {
        :raid_service => "true",
        :raid_mailto => "dummy",
        :raid_period => "123",
        :raid_remind => "456"
      }
    }

    it { should contain_augeas('set_default_mailto').with_changes('set MAILTO dummy') }
    it { should contain_augeas('set_default_period').with_changes('set PERIOD 123')  }
    it { should contain_augeas('set_default_remind').with_changes('set REMIND 456')  }

  end

end
