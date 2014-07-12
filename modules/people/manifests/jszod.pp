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

  file { "${home}/.vimrc":
    ensure  => link,
    target  => "${dotfiles_dir}/.vimrc",
    require => Repository[$dotfiles_dir]
  }

}
