# shoal

[![Build Status](https://travis-ci.org/cernops/puppet-shoal.svg?branch=master)](https://travis-ci.org/cernops/puppet-shoal)

## Overview

Configures shoal. Only the shoal agent can currently
be configured with this module. 

A shoal agent publishes via messaging the location and properties of http 
proxy servers. It is particularly intended for use with CvmFS and 
Frontier applications

* Shaol Agent https://github.com/hep-gc/shoal/tree/master/shoal-agent
* CvmFS http://cernvm.cern.ch/portal/filesystem
* Frontier http://frontier.cern.ch/

## Example

```puppet
class{'shoal::agent':
  amqp_server_url => 'shoal.heprc.uvic.ca',
  global_access   => false,
  domain_access   => true,
  logging_level   => 'DEBUG'
}
```

This will:
* Configure the shoal yum repository
* Install the shoal agent software.
* Configure the shoal agent.
* Start the shoal agent.

For details of parameters see manifests/agent.pp

## Types
A new type has been added *shoal_agent_config* based on the puppetlabs/inifile
type.

```puppet
config_shoal_agent{'general/squid_port':
   value  => '4000',
   notify => Service['shoal-agent']
}
```

would configure shoal_agent configuration with

```ini
[general]
squid_port = 4000
```

## License
Apache II license

## Copyright
2015 Steve Traylen, CERN.

