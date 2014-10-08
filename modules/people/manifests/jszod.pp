# Customizations for jszod
#
class people::jszod {
  notify { 'class people::jszod declared': }

  include people::jszod::applications
  include people::jszod::dotfiles
  include people::jszod::ruby
  include people::jszod::sublime_text

  

  # Install vim plugins using Vundle pacakge manager
  #  Need the .vim directory to be in place before this can occur
  $home = "/Users/${::boxen_user}"

  exec { 'install_vim_plugins_with_vundle':
    command => 'vim +PluginInstall +qall',
    require => File["${home}/.vim"]
  }

}
