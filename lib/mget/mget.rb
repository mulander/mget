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
  include ErrorHandling
  attr_writer :show
  def initialize()
    @download   = nil
    @convert    = nil
    @log        = Logger.new('mget.log')
    @name       = nil
    @suffix     = '.'
    @fromFile   = false
    @show       = false
    @ok         = 0
    @fail       = 0
    @skipped    = 0
    @total      = 0
    @downloaded = 0
    @convertable  = false
    
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
    puts "url                 - a valid google video, youtube, vids.myspace, smog.pl, patrz.pl or metacafe movie link"
    puts "--name,       -n    - name used to save the file, without the extension"
    puts "--input,      -i    - read links from file"
    puts "--download,   -d    - download files without asking"
    puts "--nodownload, -D    - don't download any files (also sets -C)"
    puts "--convert,    -c    - convert all downloaded and convertable files (also sets -d)"
    puts "--noconvert,  -C    - don't convert any files"
    puts "--show,       -s    - show direct download link for the video"
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
    @convertable  = true if @suffix == '.flv'
    puts  @target if @show
    convert() if download()
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
    return if @download == false
    Dir.mkdir(@saveDir) unless File.exists?(@saveDir) && File.directory?(@saveDir)
    getName() if @name.nil? || @name.empty? || @fromFile
    unless @download
      print "Download the movie (using wget) now? [Y/n] "
      unless $stdin.gets.chomp =~ /^Y/i
        @skipped += 1
        return false
      end
    end
    system("wget \"#{@target}\" -O \"#{ @saveDir }/#{ @name + @suffix}\"")
    @downloaded += 1
    return true
  end
  
  def convert()
    return if @convert  == false
    return unless @convertable
    unless @convert
      print "Convert the flv movie to mpg (using ffmpeg) now? [Y/n] "
      return false if $stdin.gets.chomp =~ /^Y/i
    end
      system("ffmpeg -i #{ @saveDir }/#{@name + @suffix} #{ @saveDir }/#@name.mpg")
      @converted += 1
      print "Delete the flv movie now? [Y/n] "
      File.delete(name + suffix) if $stdin.gets.chomp =~ /^Y/i
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


