#
# Ruby configurations for Joe Szod (jszod)
#
class people::jszod::ruby {

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

  # redcarpet gem in installed for all rubies
  ruby_gem { 'redcarpet for all rubies':
    gem           => 'redcarpet',
    version       => '~> 3.1.2',
    ruby_version  => '*',
  }

}
