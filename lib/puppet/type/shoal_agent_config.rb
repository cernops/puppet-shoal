#my_module/lib/puppet/type/shoal_agent_config.rb
Puppet::Type.newtype(:shoal_agent_config) do
  ensurable
  newparam(:name, :namevar => true) do
    desc 'Section/setting name to manage for shoal_agent.conf'
    # namevar should be of the form section/setting
    newvalues(/\S+\/\S+/)
  end
  newproperty(:value) do
    desc 'The value of the setting to be defined.'
    munge do |v|
      v.to_s.strip
    end
  end
end
