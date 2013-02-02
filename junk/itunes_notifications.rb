require 'osx/cocoa'

include OSX

class Server < NSObject
  def foo(notification)
    puts "in foo"
    p notification_to_hash(notification)
  end
  
  def notification_to_hash(notification)
    nsd = notification.userInfo
    return nsd.allKeys.to_a.inject({}){ |hash, oc_key| 
      hash[oc_key.to_s] = nsd.objectForKey(oc_key).to_s
      hash
    }
  end
end

server = Server.alloc.init

center = NSDistributedNotificationCenter.defaultCenter
center.addObserver_selector_name_object(
  server,
  "foo:", 
  "com.apple.iTunes.sourceSaved",
  nil
)
puts "running loop"
NSRunLoop.currentRunLoop.run
puts "loop end"


#nc.addObserver_selector_name_object_(GetSongs, 'getMySongs:', 'com.apple.iTunes.playerInfo',None)

