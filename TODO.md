MISC
====
    - cover logic: if season not found, try season-1
    - sickbeard processing script
      - https://gist.github.com/708284
      - https://bitbucket.org/wez/atomicparsley
      - http://handbrake.fr/downloads2.php
      - http://sickbeard.com/forums/viewtopic.php?f=3&t=5435
      - http://sickbeard.com/forums/viewtopic.php?f=8&t=4507
    - fix trashing


http://yehudakatz.com/2010/12/16/clarifying-the-roles-of-the-gemspec-and-gemfile/
http://yehudakatz.com/2010/04/02/using-gemspecs-as-intended/

TODO
====
* watcher -> bin/watcher ; scripts/watcher
* daemonize
    -
    - https://github.com/bazaarlabs/dante
* create Github repo
* use Bundler
* Capify or Vlad
* Gem
    - http://timelessrepo.com/making-ruby-gems
    - https://github.com/technicalpickles/jeweler
    - http://stackoverflow.com/questions/3307209/what-is-the-modern-way-to-structure-a-ruby-gem
    - http://guides.rubygems.org/
* CLI
    - terebi iflicks import "/whatever/tv/show/s01e02.avi"
    - terebi library add "/some/tv/show"
    - terebi library delete [episode|show|movie]
        - interactive? [Y/n]
        - pull from smart playlist
    - terebi library cleanup [movies|tv]
    - update show, update all, update episode
    - use Thor, look at foreman for examples
        - http://www.awesomecommandlineapps.com/gems.html
        - http://blog.paracode.com/2012/05/17/building-your-tools-with-thor/
        - gem: terminal-tables
        - gem: rainbow
    - run local+remote
    - https://github.com/bazaarlabs/dante/
* media library cleanup
    - delete empty dirs
    - Sickbeard+Couchpotato APIs
        + https://github.com/technoweenie/faraday
* tests
    - http://blog.arvidandersson.se/2012/03/28/minimalicous-testing-in-ruby-1-9

git pull
http://stackoverflow.com/a/978417

* change art-import to use structs
# better
class Person < Struct.new(:first_name, :last_name)
end

throw exceptions using "fail"
https://github.com/bbatsov/ruby-style-guide#exceptions

%W(foo bar baz #{var})


nice puts format: (can also refer to %s by var name)
  $stderr.puts '[%s] %s %s (%.3f s)' % [url.host, http_method, url.request_uri, duration]

ruby trick: hash.fetch

https://github.com/avdi/cowsay/blob/master/lib/cowsay.rb
http://www.ruby-doc.org/stdlib-1.9.3/libdoc/delegate/rdoc/SimpleDelegator.html#comment-527939019

ruby warnings:
http://mislav.uniqpath.com/2011/06/ruby-verbose-mode/
http://stackoverflow.com/questions/6129575/how-to-enable-ruby-warnings-in-rails
http://stackoverflow.com/questions/5591509/suppress-ruby-warnings-when-running-specs
http://devblog.avdi.org/2011/08/25/temporarily-disabling-warnings-in-ruby/
