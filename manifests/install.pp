# Installs NXLog
class nxlog::install (
  $ensure_setting = $::nxlog::ensure_setting,
  $package_name   = $::nxlog::package_name,
  $package_source = $::nxlog::package_source,
  ) {
  case $::kernel {
    'Linux'   : {
      package { $package_name:
        ensure => $ensure_setting,
      }
    }

    'Windows' : {
      if $package_source {
        package { $package_name:
          ensure   => $ensure_setting,
          source   => $package_source,
          provider => 'windows',
        }
      }
      else {
        package { $package_name:
          ensure   => $ensure_setting,
          provider => 'chocolatey',
          install_options => ['-installArgs', '"', '/VERYSILENT', '/NORESTART', '"'],
        }
      }
    } # end Windows

    default   : {
      # lint:ignore:80chars
      fail("The NXLog module is not yet supported on this ${::operatingsystem}")
      # lint:endignore
    }

  } # end $::kernel case
} # end class
