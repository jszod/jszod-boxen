# 
# Sublime text settings specific for Joe Szod (jszod)
#
class people::jszod::sublime_text {

  include 'sublime_text'

  $home = "/Users/${::boxen_user}"

  file { "${home}/Library/Application Support/Sublime Text 3/Packages/User":
    ensure  => 'directory',
    owner   => $::boxen_user,
    mode    => '0755'
  }
}
