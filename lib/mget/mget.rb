#!/usr/bin/ruby -w
#
# This file is part of the 'Movie Get' project.
#
# Copyright (C) 2006 Adam Wolk "mulander" <netprobe@gmail.com>
#                                "defc0n" <defc0n@da-mail.net>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

require 'mget/error_handling'

class Mget
  VERSION = '1.17'
  include ErrorHandling
  attr_writer :show, :quiet
  def initialize()
    @quiet      = false
    @download   = nil
    @convert    = nil
    @remove     = nil
    @log        = Logger.new(logDir() + 'mget.log')
    @name       = nil
    @fromFile   = false
    @show       = false
    @ok         = 0
    @fail       = 0
    @skipped    = 0
    @total      = 0
    @downloaded = 0
    @converted  = 0
    @convertable= false
    @saveDir    = '.'
    
    if ENV.has_key?('OS')
      @wget   = File.exists?(ENV['SystemRoot'] + '\wget.exe')
      @ffmpeg = File.exists?(ENV['SystemRoot'] + '\ffmpeg.exe')
      @mplayer= File.exists?(ENV['SystemRoot'] + '\mplayer')
    else
      `which wget`
      @wget   = ($?.exitstatus == 0)
      `which ffmpeg`
      @ffmpeg = ($?.exitstatus == 0)
      `which mplayer`
      @mplayer =($?.exitstatus == 0)
    end
            
    setInfo("If you want to download movies, you must install" + \
          " wget (http://www.gnu.org/software/wget/)\n") unless @wget
    
    setInfo("If you want to convert movies, you must install" + \
          " ffmpeg (http://sourceforge.net/projects/ffmpeg/)") unless @ffmpeg
          
    setInfo("If you want to download mms:// streams you must install" + \
          " mplayer (http://mplayerhq.hu/)") unless @mplayer
    
  end
  
  def target=(target)
    Mget.help() if target.nil?
    if target.nil? || target !~ /^http:\/\//
      setWarning("Invalid url: #{ target }")
      Mget.help()
      @target = nil
    else
      @target = target
    end
  end
  
  def download=(flag)
    return unless @download.nil?
    @download = flag
    @convert  = false unless @download
  end
  
  def convert=(flag)
    return unless @convert.nil?
    @convert  = flag
    @download = true if @convert
  end
  
  def remove=(flag)
    return unless @convert.nil?
    @convert  = flag
  end
  
  def name=(saveName)
    if @fromFile
      setWarning("--name ignored because of --input")
      return
    elsif File.exists? saveName
      setWarning("File already exists: #{ saveName }")
      exit
    else
      @name = saveName
    end

  end
  
  def input=(fileName)
    if File.exists? fileName
      if File.zero? fileName
        setError("File is empty: #{ fileName }")
        exit
      else
        unless @name.nil? || @name.empty?
          setWarning("--name ignored because of --input")
          @name   = nil
        end
        @fromFile = true
        @input    = fileName
      end
    else
      setError("File does not exist: #{ fileName }")
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
    puts %{
Usage:   #{ scriptName } [options] url
url                 - a valid google video, youtube, vids.myspace, 
                        patrz.pl, wrzuta.pl (also audio), itvp.pl
                        movies.yahoo.com, interia.pl, onet.pl, funpic.hu,
                        glumbert, habtv.hu, gazeta.pl, dailymotion.com,
                        allocine.fr
                        or metacafe movie link
--name,       -n    - name used to save the file, without the extension
--input,      -i    - read links from file
--download,   -d    - download files without asking
--nodownload, -D    - don't download any files (also sets -C)
--convert,    -c    - convert all downloaded and convertable files (also sets -d)
--noconvert,  -C    - don't convert any files
--remove,     -r    - remove leftover file after conversion
--noremove,   -R    - never remove leftover file after conversion
--show,       -s    - show direct download link for the video
--quiet,      -q    - hides output from wget
--version,    -v    - display version information
}
    exit
  end

  def Mget.version()
 puts %{
Movie Get v#{VERSION} - http://green.kom.pl/~mget
Copyright (C) 2006 Adam Wolk "mulander" <netprobe@gmail.com>
                             "defc0n" <defc0n@da-mail.net> 
  }
  exit
  end

private

  def stats()
    print "+","="*17,"+\n"
    printf  "|%-17s|\n","Statistics"
    print "+","="*17,"+\n"
    printf "|%06d %-10s|\n|%06d %-10s|\n|%06d %-10s|\n",@ok,"ok",@fail,"fail",@skipped,"skipped"
    print "+","="*17,"+\n"
    printf "|%06d %-10s|\n|%06d %-10s|\n",@downloaded,"downloaded",@converted,"converted"
    print "+","="*17,"+\n"
  end

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
      when /movies\.yahoo\.com/
        require 'mget/yahoo'
        movie   = Yahoo.new(@target,nil)
      when /vids\.myspace/
        require 'mget/my_space'
        movie   = MySpace.new(@target,nil)
      when /patrz/
        require 'mget/patrz'
        movie   = Patrz.new(@target,nil)
      when /wrzuta/
        require 'mget/wrzuta'
        movie   = Wrzuta.new(@target,nil)
      when /itvp\.pl/
        require 'mget/itvp'
        movie   = ITVP.new(@target,nil)
      when /glumbert/
        require 'mget/glumbert'
        movie = Glumbert.new(@target,nil)
      when /funpic/
        require 'mget/funpic'
        movie = Funpic.new(@target,nil)
      when /habtv/
        require 'mget/habtv'
        movie = HabTV.new(@target,nil)
      when /interia/
        require 'mget/interia'
        movie = Interia.new(@target,nil)
      when /onet/
        require 'mget/onet'
        movie = Onet.new(@target,nil)
      when /allocine/
        require 'mget/allocine'
        movie = Allocine.new(@target,nil)
      when /gazeta/
        require 'mget/gazeta'
        movie = Gazeta.new(@target,nil)
      when /dailymotion/
        require 'mget/dailymotion'
        movie = Dailymotion.new(@target,nil)
      else
        setError("Unsupported site: #{@target}")
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
    
    @suffix     = movie.suffix()
    @mms        = movie.mms?
    @saveDir    = movie.class.to_s if @fromFile
    @movieSite  = movie.class.to_s
    @convertable= true if @suffix == '.flv'
    puts  @target if @show
    convert() if download()
    @name       = nil
    @ok += 1
  end
  
  def fileLoop()
    curr = 1
    open(@input) do |f|
      f.each_line { @total += 1 }
      f.seek(0)
      f.each_line do |line|
        next if line.empty? || line =~ /^#/
        self.target = line
        next if @target.nil?
        printf "[*] %d/%d...\n", curr,@total
        getMovie()
        curr += 1
      end
    end
    stats()
  end
  
  def ask(question)
    print question + ' [Y/n] '
    answer  = $stdin.gets.chomp
    return (answer.empty? || answer =~ /^Y/i)
  end
  
  def download()
    return if @download == false
    unless @download
      unless ask("Download the movie (using " +(@mms ? 'mplayer' : 'wget')+ ") now?")
        @skipped += 1
        return false
      end
    end
    flag  = (@quiet) ? '-q ' : ''
    
    Dir.mkdir(@saveDir) unless File.exists?(@saveDir) && File.directory?(@saveDir) if @fromFile
    
    getName() if @name.nil? || @name.empty? || @fromFile
    
    if @mms
      system("mplayer -dumpstream -dumpfile \"#{ @saveDir }/#{ @name + @suffix }\" \"#@target\"")
    else
      system("wget #{ flag }\"#{@target}\" -O \"#{ @saveDir }/#{ @name + @suffix}\"")
    end
    @downloaded += 1
    return true
  end
  
  def convert()
    return if @convert  == false
    return unless @convertable
    unless @convert
      return false unless ask("Convert the flv movie to mpg (using ffmpeg) now?")
    end
      system("ffmpeg -i #{ @saveDir }/#{@name + @suffix} #{ @saveDir }/#@name.mpg")
      @converted += 1
      return false if @remove == false
      unless @remove
        return false unless ask("Delete the flv movie now?")
      end
      File.delete(@saveDir + '/' + @name + @suffix)
  end

  def getName()
    dirInfo = Dir.entries(@saveDir).find_all { |p| p =~ /#{@movieSite}\d{6}/ }
    if dirInfo.length.zero?
      @name = @movieSite + '0'*6
    else
      @name = dirInfo.map { |e| e.gsub(/\..{3}$/,'') }.uniq.max.succ
    end
  end  
end


