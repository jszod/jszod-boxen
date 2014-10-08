# 
# Sublime Text settings specific for Joe Szod (jszod)
#
class people::jszod::sublime_text {

  include 'sublime_text'

  $home = "/Users/${::boxen_user}"

  file { "${home}/Library/Application Support/Sublime Text 3/Packages/User":
    ensure  => 'directory',
    owner   => $::boxen_user,
    mode    => '0755'
  }

  # Packages
  sublime_text::package { 'Markdown-Preview':
    source => 'revolunet/sublimetext-markdown-preview'
  }

  sublime_text::package { 'Monokai Extended':
    source => 'jonschlinkert/sublime-monokai-extended'
  }

  sublime_text::package { 'Dayle-Rees-Color-Schemes':
    source => 'daylerees/colour-schemes'
  }

}
