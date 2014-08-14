#
# Dotfile configuration for Joe Szod (jszod)
#
class people::jszod::dotfiles {

  # Setup .dotfiles variables
  $home = "/Users/${::boxen_user}"
  $dotfiles_dir = "${boxen::config::srcdir}/dotfiles"

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
