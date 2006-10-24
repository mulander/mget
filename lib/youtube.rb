require 'movie_site'

class Youtube < MovieSite
  def initialize(url,config)
    super(url,config)
    if @url =~ /(\/watch.+)/
      @base  = 'youtube.com'
      @watch = $1
    else
      raise ArgumentError("Invalid Youtube link")
    end
  end
  
  def get()
    id = ''
    open(@url,{'Cookie' => @cookie, 'User-Agent' => @useragent}) do |f|
      if adult?(f.base_uri.to_s)
        until loggedIn?
          askAccountInfo() unless usernameSet? && passwordSet?
          login
        end
        confirm
        return get()
      end
      f.each_line do |line|
          if line =~ /embed src="(http:\/\/.+?)"/
            open($1,{'Cookie' => @cookie, 'User-Agent' => @useragent}) { |d| id = d.base_uri.to_s.scan(/.+video_id=(.+)/) }
            return "http://youtube.com/get_video.php?video_id=#{id}"
          end
        end
      end
  end
  
  private
  
  def login() # seems to work
    res = Net::HTTP.post_form(URI.parse('http://' + @base + '/login?next_url=' + @watch),
                              {'current_form' => 'loginForm','username' => @username,
                               'password' => @password, 'next_url' => @watch,
                               'action_login' => 'Log In' })
  # Youtube sends 303 on a valid login attempt and 200 if failed
    case res.code
      when '303'
        @cookie   = res['set-cookie'].split(' ').find_all { |p| p =~ /use|INFO/ }
        @cookie   = @cookie.join(' ')
        @loggedIn = true
        return true
      when '200'
        @username = ''
        @password = ''
        puts "[*] Invalid username or password"
        return false
      end
  end
  
  def confirm
    data = 'next_url=#@watch&action_confirm=Confirm'
    headers = {
      'Cookie' => @cookie,
      'Content-Type' => 'application/x-www-form-urlencoded'
    }
    http    =   Net::HTTP.new(@base,80)
    res     =   http.post(@confirm, data, headers)
    @cookie +=  ' ' + res['set-cookie'].split(' ').find { |p| p =~ /is_adult/ }
  end
  
  def adult?(url)
    if url =~ /(\/verify_age.+)/
      @confirm = $1
      return true
    else
      return false
    end
  end
end
