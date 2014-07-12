# Customizations for jszod
class people::jszod {
  notify { 'class people::jszod declared': }

  # Setup .dotfiles variables
  $home = "/Users/${::boxen_user}"
  $dotfiles_dir = "${boxen::config::srcdir}/dotfiles"

  # Apps
  # ----------------------------------------------
  include appcleaner
  include hipchat
  include skype
##  include omnigraffle
  include macvim

  # Specify the global ruby version
  # ----------------------------------------------
  # Somehow setting the ruby::global::version varialbe in hiera does not work
  # Set the value explicitly in a file to mimic the 'rbenv global' command
  file { 'version':
    path    => '/opt/boxen/rbenv/version',
    content => '2.1.1',
  }

  # .dotfile configuration
  # ----------------------------------------------
  repository { $dotfiles_dir:
    source => "${::github_login}/dotfiles"
  }

  file { "${home}/.vim":
    ensure  => link,
    force   => true,   # Overwrite if the directory alread exists
    backup  => false,  # Don't backup directory if it alread exists, just replace it
    target  => "${dotfiles_dir}/vim",
    require => Repository[$dotfiles_dir]
  }

  file { "${home}/.vimrc":
    ensure  => link,
    target  => "${dotfiles_dir}/vimrc",
    require => Repository[$dotfiles_dir]
  }

  # Install vim plugins using Vundle pacakge manager
  exec { "install_vim_plugins_with_vundle":
    command => "vim +PluginInstall +qall"
  }
}
