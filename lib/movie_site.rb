require 'open-uri'
require 'net/http'
require 'uri'

class MovieSite
  def initialize(url,config)
    @url      = url
    @cookie   = ''
    @loggedIn = false
    @useragent= 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.1) Gecko/20060111'
    @username = config['username']
    @password = config['password']
  end
  
  private
  
  def passwordSet?
    return (@password.nil? || @password.empty?) ? false : true
  end
  def usernameSet?
    return (@username.nil? || @username.empty?) ? false : true
  end
  
  def loggedIn?
    return @loggedIn
  end
 
  def askPassword
    print "#{ self.class } password: "
    @password = $stdin.gets.chomp
  end
  
  def askUsername
    print "#{ self.class } username: "
    @username = $stdin.gets.chomp
  end  

  def askAccountInfo
    puts "#{ self.class } decided that in order to view this movie you must identify"
    until usernameSet?
      askUsername()
    end
    
    until passwordSet?
      askPassword()
    end
  end

end
