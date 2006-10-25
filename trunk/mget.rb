#!/usr/bin/ruby -w
# v0.09
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

$LOAD_PATH.push('lib')

require 'getoptlong'

class Mget
  @@youtube = { 'username' => '', 'password' => '' }
  
  def initialize()
    @name     = nil
    @suffix   = '.'
    @convert  = false
    @fromFile = false
    `which wget`
    @wget   = ((ENV.has_key?('OS') && File.exists?(ENV['SystemRoot'] + '\wget.exe')) \
            || $?.exitstatus )? true : false
    
    `which ffmpeg`
    @ffmpeg = ( (ENV.has_key?('OS') && File.exists?(ENV['SystemRoot'] + '\ffmpeg.exe')) \
            || $?.exitstatus )? true : false
            
    print "[*] If you want to download movies, you must install" + \
          " wget (http://www.gnu.org/software/wget/)\n" unless @wget
    
    print "[*] If you want to convert movies, you must install" + \
          " ffmpeg (http://sourceforge.net/projects/ffmpeg/)" unless @ffmpeg
    
  end
  
  def target=(target)
    if target.nil? || target !~ /^http:\/\//
      puts "[*] Invalid url"
      exit
    else
      @target = target
    end
  end
  
  def name=(saveName)
    if @fromFile
      puts "[*] --name ignored because of --input"
      return
    elsif File.exists? saveName
      puts "[*] File already exists: #{ saveName }"
      exit
    else
      @name = saveName
    end

  end
  
  def input=(fileName)
    if File.exists? fileName
      if File.zero? fileName
        puts "[*] File is empty: #{ fileName }"
        exit
      else
        unless @name.nil? || @name.empty?
          puts "[*] --name ignored because of --input"
          @name   = nil
        end
        @fromFile = true
        @input    = fileName
      end
    else
      puts "[*] File does not exist: #{ fileName }"
      exit
    end
  end
  
  def fromFile?()
    return @fromFile
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
        print "[*] Unsupported site: #{@target}"
        exit
    end
    @target   = movie.get()
    @suffix  += movie.suffix()
    @convert  = true if @suffix == '.flv'
    puts  @target
    download()
    convert()
  end
  
  def fileLoop(target)
    # TODO - iterate over input file and get each movie
  end
  
  def download()
    return if @name.nil? || @name.empty? # FIXME - get a default name when no name is given
    print "Download the movie (using wget) now? [Y/n] "
    exit unless $stdin.gets.chomp =~ /^Y/i
    system("wget \"#{@target}\" -O \"#{@name + @suffix}\"")
    convert()
  end
  
  def convert()
    return if @name.nil? || @name.empty? # FIXME - related to download()
    return unless @convert
    print "Convert the flv movie to mpg (using ffmpeg) now? [Y/n] "
    if $stdin.gets.chomp =~ /^Y/i
      system("ffmpeg -i #{@name + suffix} #@name.mpg")
      print "Delete the flv movie now? [Y/n] "
      File.delete(name + suffix) if $stdin.gets.chomp =~ /^Y/i
    end
  end

public

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
end

opts = GetoptLong.new(
  ["--help","-h",   GetoptLong::NO_ARGUMENT],
  ["--name","-n",   GetoptLong::REQUIRED_ARGUMENT],
  ["--input","-i",  GetoptLong::REQUIRED_ARGUMENT]
)

opts.ordering = GetoptLong::REQUIRE_ORDER

mget = Mget.new()

opts.each do |opt, arg|
  case opt
    when '--help'
      Mget.help()
    when '--name'
      mget.name   = arg
    when '--input'
      mget.input  = arg
  end
end

mget.target = ARGV[0] unless mget.fromFile?

mget.run()