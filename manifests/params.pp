# Class shoal::params
# Defaults
class shoal::params {
  $agentversion    = 'present'
  $yum_baseurl     = 'http://shoal.heprc.uvic.ca/repo/prod'
  $amqp_server_url = 'localhost'
  $global_access   = false
  $domain_access   = true
  $logging_level   = 'ERROR'
}
