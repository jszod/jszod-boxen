# Ruby Puppet Module for Boxen

[![Build Status](https://travis-ci.org/boxen/puppet-ruby.png?branch=master)](https://travis-ci.org/boxen/puppet-ruby)

Requires the following boxen modules:

* `boxen >= 3.2.0`
* `repository >= 2.1`
* `xquartz` (OS X only)
* `autoconf` (some ruby versions)
* `openssl` (ruby versions >= 2.0.0)
* `gcc` (ruby versions <= 1.8.7)
* [ripienaar/puppet-module-data](https://github.com/ripienaar/puppet-module-data)

## About

This module supports ruby version management with either rbenv or chruby.
All ruby versions are installed into `/opt/rubies`.

## Breakages since last major version

* `ruby::global` does not work with chruby
* rbenv plugin support is gone
* bundler is no longer installed by default
* rubies now live in /opt/rubies instead of /opt/boxen/rbenv/versions
* the module-data module is now **required**

## Usage

```puppet
# Set the global default ruby (auto-installs it if it can)
class { 'ruby::global':
  version => '1.9.3'
}

# ensure a certain ruby version is used in a dir
ruby::local { '/path/to/some/project':
  version => '1.9.3-p194'
}

# ensure a gem is installed for a certain ruby version
# note, you can't have duplicate resource names so you have to name like so
$version = "2.0.0"
ruby_gem { "bundler for ${version}":
  gem          => 'bundler',
  version      => '~> 1.2.0',
  ruby_version => $version,
}

# ensure a gem is installed for all ruby versions
ruby_gem { 'bundler for all rubies':
  gem          => 'bundler',
  version      => '~> 1.0',
  ruby_version => '*',
}

# install a ruby version
ruby::version { '1.9.3-p194': }

# Installing rbenv plugin
ruby::plugin { 'rbenv-vars':
  ensure => 'v1.2.0',
  source  => 'sstephenson/rbenv-vars'
}

# Run an installed gem
exec { '/opt/rubies/2.1.0/bin/bundle install':
  cwd     => "~/src/project",
  require => ruby_gem['bundler for 2.1.0']
}
```

## Hiera configuration

The following variables may be automatically overridden with Hiera:

``` yaml
---

"ruby::provider": "chruby"
"ruby::user": "deploy"

"ruby::build::ensure": "v0.3.8"
"ruby::chruby::ensure": "v0.3.6"
"ruby::rbenv::ensure": "v0.4.0"

# Environment variables for building specific versions
# You'll want to enable hiera's "deeper" merge strategy
# See http://docs.puppetlabs.com/hiera/1/configuring.html#mergebehavior
"ruby::version::env":
  "1.9.3-gentoo":
    "CC": "llvm"
    "CFLAGS": "-O9 -funroll-loops"
  "2.0.0-p0":
    "CC": "gcc"

# Version aliases, commonly used to bless a specific version
# Use the "deeper" merge strategy, as with ruby::version::env
"ruby::version::alias":
  "1.9.3": "1.9.3-p484"
  "2.0.0": "2.0.0-github"
  "2.0.0-github": "2.0.0-github6"
```

It is **required** that you include
[ripienaar/puppet-module-data](https://github.com/ripienaar/puppet-module-data)
in your boxen project, as this module now ships with many pre-defined versions
and aliases in the `data/` directory. With this module included, those
definitions will be automatically loaded, but can be overridden easily in your
own hierarchy.

You can also use JSON if your Hiera is configured for that.
