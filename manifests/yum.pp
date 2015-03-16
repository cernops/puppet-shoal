# Class shoal::yum , configures yum repositorit for shoal.
class shoal::yum (
  $yum_baseurl = $shoal::params::yum_baseurl
) inherits shoal::params {
  yumrepo{'shoal':
    enabled  => '1',
    gpgcheck => '0',
    descr    => 'Shoal Repository',
    gpgkey   => 'http://hepnetcanada.ca/pubkeys/igable.asc',
    priority => '2',
    baseurl  => $yum_baseurl
  }
}
