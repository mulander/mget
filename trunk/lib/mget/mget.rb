#!/usr/bin/ruby -w

require 'mget/error_handling'

class Mget
  include ErrorHandling
  def initialize()
    @log      = Logger.new('mget.log')
    @name     = nil
    @suffix   = '.'
    @convert  = false
    @fromFile = false
    @ok       = 0
    @fail     = 0
    @total    = 0

    if ENV.has_key?('OS')
      @wget   = File.exists?(ENV['SystemRoot'] + '\wget.exe')
      @ffmpeg = File.exists?(ENV['SystemRoot'] + '\ffmpeg.exe')
    else
      `which wget`
      @wget   = ($?.exitstatus == 0)
      `which ffmpeg`
      @ffmpeg = ($?.exitstatus == 0)
    end
            
    setInfo("If you want to download movies, you must install" + \
          " wget (http://www.gnu.org/software/wget/)\n") unless @wget
    
    setInfo("If you want to convert movies, you must install" + \
          " ffmpeg (http://sourceforge.net/projects/ffmpeg/)") unless @ffmpeg
    
  end
  
  def target=(target)
    if target.nil? || target !~ /^http:\/\//
      setWarning("Invalid url: #{ target }")
      unless @fromFile
        Mget.help()
        exit
      end
      @target = nil
    else
      @target = target
    end
  end
  
  def name=(saveName)
    if @fromFile
      setWarning("--name ignored because of --input")
      return
    elsif File.exists? saveName
      setWarning("[*] File already exists: #{ saveName }")
      exit
    else
      @name = saveName
    end

  end
  
  def input=(fileName)
    if File.exists? fileName
      if File.zero? fileName
        setError("[*] File is empty: #{ fileName }")
        exit
      else
        unless @name.nil? || @name.empty?
          setWarning("[*] --name ignored because of --input")
          @name   = nil
        end
        @fromFile = true
        @input    = fileName
      end
    else
      setError("[*] File does not exist: #{ fileName }")
      exit
    end
  end
  
  def fromFile?()
    return @fromFile
  end
  
  def run()
    if @fromFile
      fileLoop()
    else
      getMovie()
    end
  end
  
  def Mget.help()
    scriptName  = $0
    scriptName = 'mget' if ENV.has_key?('OS')
    puts "Usage:   #{ scriptName } [options] url"
    puts "url           - a valid google video, youtube, vids.myspace, smog.pl, patrz.pl or metacafe movie link"
    puts "--name,   -n  - name used to save the file, without the extension"
    puts "--input,  -i  - read links from file"
    exit
  end

private

  def getMovie()
    movie   = nil
    case @target
      when /youtube/
        require 'mget/youtube'
        movie   = Youtube.new(@target, @@youtube)
      when /metacafe/
        require 'mget/meta_cafe'
        movie   = MetaCafe.new(@target,nil)
      when /google/
        require 'mget/google'
        movie   = Google.new(@target,nil)
      when /vids\.myspace/
        require 'mget/my_space'
        movie   = MySpace.new(@target,nil)
      when /patrz/
        require 'mget/patrz'
        movie   = Patrz.new(@target,nil)
      when /wrzuta/
        require 'mget/wrzuta'
        movie   = Wrzuta.new(@target,nil)
      else
        setError("[*] Unsupported site: #{@target}")
        exit
    end
    @target   = movie.get()
    
    if movie.error?
      @fail += 1
      if @fromFile
        return
      else
        exit
      end
    end
    
    @suffix  += movie.suffix()
    @saveDir  = movie.class.to_s
    @convert  = true if @suffix == '.flv'
    puts  @target
    download()
    convert()
    @ok += 1
  end
  
  def fileLoop()
    open(@input) do |f|
      f.each_line { @total += 1 }
      f.seek(0)
      f.each_line do |line|
        # TODO - Get each movie
        curr = 0
        next if line.empty? || line =~ /^#/
        self.target = line
        next if @target.nil?
        printf "[*] %d/%d...", curr,@total
        getMovie()
        print "done\n"
        curr += 1
      end
    end
  end
  
  def download()
    Dir.mkdir(@saveDir) unless File.exists?(@saveDir) && File.directory?(@saveDir)
    getName() if @name.nil? || @name.empty? || @fromFile
    print "Download the movie (using wget) now? [Y/n] "
    exit unless $stdin.gets.chomp =~ /^Y/i
    system("wget \"#{@target}\" -O \"#{ @saveDir }/#{ @name + @suffix}\"")
  end
  
  def convert()
    return if @name.nil? || @name.empty? # FIXME - related to download()
    return unless @convert
    print "Convert the flv movie to mpg (using ffmpeg) now? [Y/n] "
    if $stdin.gets.chomp =~ /^Y/i
      system("ffmpeg -i #{ @saveDir }/#{@name + @suffix} #@name.mpg")
      print "Delete the flv movie now? [Y/n] "
      File.delete(name + suffix) if $stdin.gets.chomp =~ /^Y/i
    end
  end

  def getName()
    dirInfo = Dir.entries(@saveDir).find_all { |p| p =~ /\d{1,6}/ }
    if dirInfo.length.zero?
      @name = @saveDir + '0'*6
    else
      @name = dirInfo.map { |e| e.gsub(/\..{3}$/,'') }.uniq.max.succ
    end
  end  
end


