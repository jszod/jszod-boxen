class people::jszod {
   notify { 'class people::jszod declared': }

   include appcleaner
   include hipchat
   include skype
   include omnigraffle

   # Specify the global ruby version
   # Somehow setting the ruby::global::version varialbe in hiera does not work
   # Set the value explicitly in a file to mimic the 'rbenv global' command
   file { 'version':
     path => '/opt/boxen/rbenv/version',
     content => '2.1.1',
   }
}
