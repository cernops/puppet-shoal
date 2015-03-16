require 'spec_helper'
describe 'shoal::agent' do

  context 'with defaults for all parameters' do
    it { should contain_class('shoal::agent') }
    it { should contain_yumrepo('shoal') }
    it { should contain_package('shoal-agent').with_ensure('present') }
    it { should contain_service('shoal-agent').with_ensure(true) }
    it { should contain_shoal_agent_config('general/domain_access').with_value('True') }
    it { should contain_shoal_agent_config('general/global_access').with_value('False') }
    it { should contain_shoal_agent_config('rabbitmq/amqp_server_url').with_value('localhost') }
    it { should contain_shoal_agent_config('logging/logging_level').with_value('ERROR') }
  end

  context 'with overridden parameters' do
    let :params do
    {  :agentversion    => '1.2',
       :amqp_server_url => 'rabbit.example.org',
       :domain_access   => false,
       :global_access   => true,
       :logging_level  => 'DEBUG' }
    end
    it { should contain_class('shoal::agent') }
    it { should contain_yumrepo('shoal') }
    it { should contain_package('shoal-agent').with_ensure('1.2') }
    it { should contain_service('shoal-agent').with_ensure(true) }
    it { should contain_shoal_agent_config('general/domain_access').with_value('False') }
    it { should contain_shoal_agent_config('general/global_access').with_value('True') }
    it { should contain_shoal_agent_config('rabbitmq/amqp_server_url').with_value('rabbit.example.org') }
    it { should contain_shoal_agent_config('logging/logging_level').with_value('DEBUG') }

  end

end
