# == Class: shoal::agent
#
# Installs and configurat shoal-agent
#
# === Variables
#
# [*agentversion*]
#   version of package to install, by default it is just 'present'
#
# [*ampq_server_url*]
#   Hostname of ampq server url, defaults to 'localhost'.
#
# [*global_access*]
#   Boolean , can the proxy service be accessed globally by clients.
#
# [*domain_access*]
#   Boolean , provide this squid only to clients in same domain.
#
# [*logging_access*]
#   Set to INFO, WARN, ERROR, DEBUG. By default it is ERROR
#
# === Examples
#
#   class{'shoal::agent':
#      amqp_server_url => 'shoal.heprc.uvic.ca',
#      global_access   => false,
#      domain_access   => true,
#      logging_level   => 'DEBUG'
#   }
#
# === Authors
#
# Author Steve Traylen <steve.traylen@cern.ch>
#
# === Copyright
#
# Copyright 2015 Steve Traylen, CERN
#
class shoal::agent (
  $agentversion    = $shoal::params::agentversion,
  $amqp_server_url = $shoal::params::amqp_server_url,
  $global_access   = $shoal::params::global_access,
  $domain_access   = $shoal::params::domain_access,
  $logging_level   = $shoal::params::logging_level
) inherits shoal::params {

  class{'shoal::yum':}

  package{'shoal-agent':
    ensure  => $agentversion,
    require => Yumrepo['shoal']
  }
  file{'/var/log/shoal_agent.log':
    ensure  => file,
    replace => false,
    owner   => nobody,
    group   => nobody,
    mode    => '0644'
  }
  Shoal_agent_config{
    require => Package['shoal-agent'],
    notify  => Service['shoal-agent']
  }
  shoal_agent_config{'rabbitmq/amqp_server_url':
    value => $amqp_server_url
  }
  if $global_access  {
    $global_access_string = 'True'
  } else {
    $global_access_string = 'False'
  }
  shoal_agent_config{'general/global_access':
    value => $global_access_string
  }
  if $domain_access  {
    $domain_access_string = 'True'
  } else {
    $domain_access_string = 'False'
  }
  shoal_agent_config{'general/domain_access':
    value => $domain_access_string
  }

  shoal_agent_config{'logging/logging_level':
    value => $logging_level
  }

  service{'shoal-agent':
    ensure    => true,
    enable    => true,
    hasstatus => true,
    require   => File['/var/log/shoal_agent.log']
  }

}

