#
# Applications specific to Joe Szod (jszod)
#
class people::jszod::applications {

  include 'appcleaner'
  include 'brewcask'
  include 'elixir'
  include 'erlang'
  include 'gitflow'
  include 'hipchat'
  include 'iterm2::stable'
  include 'java'
  include 'macvim'        # Vim packages maintained in .vimrc via vundle
  include 'omnigraffle'
  include 'sourcetree'
  include 'skype'
  include 'tmux'
  include 'xmind'
#  include 'syncplicity'
  #include 'astah_community'
  include 'xquartz'
}
