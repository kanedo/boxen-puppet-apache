# A Boxen-focused Apache Vhost setup helper
#
# Options:
#
#     docroot =>
#       The directory to use as the document root.
#       Defaults to "${boxen::config::srcdir}/${name}".
#
#     port =>
#       Port for Apache to listen on.
#		Defaults to 80.
#

define apache::vhost(
  $port = undef,
  $docroot  = undef,
  $host = undef,
) {
  require apache
  $port = $port ? {
  	undef	=> 80,
	default => $port
  }
  $vhost_docroot = $docroot ? {
    undef   => "${boxen::config::srcdir}/${name}",
    default => $docroot
  }

  $hostname = $host ? {
    undef   => "${name}.dev",
    default => $host
  }

  file { "${apache::config::sitesdir}/${name}.conf":
    content => template('apache/config/apache/vhost.conf.erb'),
    require => File[$apache::config::sitesdir],
    #notify  => Service['org.apache.httpd'],
  }

}