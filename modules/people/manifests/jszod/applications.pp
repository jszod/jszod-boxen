#
# Applications specific to Joe Szod (jszod)
#
class people::jszod::applications {

  include 'appcleaner'
  include 'brewcask'
  include 'elixir'
  include 'erlang'
  include 'hipchat'
  include 'skype'
  include 'omnigraffle'
  include 'macvim'        # Vim packages maintained in .vimrc via vundle
  include 'tmux'
  include 'java'
  include 'xmind'
  include 'sourcetree'
  include 'iterm2::stable'
#  include 'syncplicity'
  #include 'astah_community'
  include 'xquartz'
  include 'gitflow'

}
