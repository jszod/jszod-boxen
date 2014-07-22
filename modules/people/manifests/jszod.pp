# Customizations for jszod
#
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
  include tmux
  include java
  include xmind
  include sourcetree
  include sublime_text
  include iterm2::stable

  # Ruby configuration
  # ---------------------------------------------

  # Specify the global ruby version
  # Somehow setting the ruby::global::version varialbe in hiera does not work
  # Set the value explicitly in a file to mimic the 'rbenv global' command
  file { 'version':
    path    => '/opt/boxen/rbenv/version',
    content => '2.1.1',
  }

  # bundler gem is installed for my defautl ruby
  $version = '2.1.1'
  ruby_gem { "bundler for ${version}":
    gem           => 'bundler',
    version       => '~> 1.2.0',
    ruby_version  => $version,
  }

  # bundler gem is installed for all ruby versions
  ruby_gem { 'bundler for all rubies':
    gem           => 'bundler',
    version       => '~> 1.0',
    ruby_version  => '*',
  }

  # tmuxinator gem is installed
  ruby_gem { "tmuxinator for ${version}":
    gem           => 'tmuxinator',
    version       => '~> 0.6.8',
    ruby_version  => $version,
  }

  ruby_gem { 'tmuxinator for all versions':
    gem           => 'tmuxinator',
    version       => '~> 0.6.8',
    ruby_version  => '*',
  }


  # .dotfile configuration
  # ----------------------------------------------
  repository { $dotfiles_dir:
    source => "${::github_login}/dotfiles"
  }

 file { "${home}/.bash_profile":
    ensure  => link,
    target  => "${dotfiles_dir}/bash_profile",
    require => Repository[$dotfiles_dir]
  }

 file { "${home}/.bashrc":
    ensure  => link,
    target  => "${dotfiles_dir}/bashrc",
    require => Repository[$dotfiles_dir]
  }

  file { "${home}/.vim":
    ensure  => link,
    force   => true,   # Overwrite if the directory alread exists
    backup  => false,  # Don't backup directory if it already exists
    target  => "${dotfiles_dir}/vim",
    require => Repository[$dotfiles_dir]
  }

  file { "${home}/.vimrc":
    ensure  => link,
    target  => "${dotfiles_dir}/vimrc",
    require => Repository[$dotfiles_dir]
  }

  # Install vim plugins using Vundle pacakge manager
  #  Need the .vim directory to be in place before this can occur
  exec { 'install_vim_plugins_with_vundle':
    command => 'vim +PluginInstall +qall',
    require => File["${home}/.vim"]
  }

  # tmux
  file { "${home}/.tmux.conf":
    ensure  => link,
    target  => "${dotfiles_dir}/tmux.conf",
    require => Repository[$dotfiles_dir]
  }

  # tmuxinator
  file { "${home}/.tmuxinator":
    ensure  => link,
    force   => true,
    backup  => false,
    target  => "${dotfiles_dir}/tmuxinator}",
    require => Repository[$dotfiles_dir]
  }

}
