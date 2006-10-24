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

url         = ARGV[0]
name        = ARGV[1]
scriptName  = $0
suffix      = '.'
target      = ''

youtube     = { 'username' => '', 'password' => '' }

scriptName = 'mget' if ENV.has_key?('OS')

if url.nil? || url !~ /^http:\/\// || name.nil?
 puts "Usage:   #{ scriptName } url name"
 puts "url      - a valid google video, youtube, vids.myspace, smog.pl, patrz.pl or metacafe movie link"
 puts "filename - name used to save the file, without the extension"
 exit
end

convert = false
movie   = nil

case url
  when /youtube/
    require 'mget/youtube'
    movie   = Youtube.new(url, youtube)
  when /metacafe/
    require 'mget/meta_cafe'
    movie   = MetaCafe.new(url,nil)
  when /google/
    require 'mget/google'
    movie   = Google.new(url,nil)
  when /vids\.myspace/
    require 'mget/my_space'
    movie   = MySpace.new(url,nil)
  when /patrz/
    require 'mget/patrz'
    movie   = Patrz.new(url,nil)
  when /smog/
    require 'mget/smog'
    movie   = Smog.new(url,nil)
  else
    print "Unsupported site: #{url}"
    exit
end

target  = movie.get()
suffix  = movie.suffix()
convert = true if suffix == 'flv'

puts  target
if (ENV.has_key?('OS') && File.exists?(ENV['SystemRoot'] + '\wget.exe')) || system('which wget')
  print "Download the movie (using wget) now? [Y/n] "
  exit unless $stdin.gets.chomp =~ /^Y/i
    system("wget \"#{target}\" -O \"#{name + suffix}\"")

  if convert && ( (ENV.has_key?('OS') && File.exists?(ENV['SystemRoot'] + '\ffmpeg.exe')) || system('which ffmpeg') )
    print "Convert the flv movie to mpg (using ffmpeg) now? [Y/n] "
    if $stdin.gets.chomp =~ /^Y/i
      system("ffmpeg -i #{name + suffix} #{name}.mpg")
      print "Delete the flv movie now? [Y/n] "
      File.delete(name + suffix) if $stdin.gets.chomp =~ /^Y/i
    end
  else
    print "If you want to convert movies, you must install ffmpeg (http://sourceforge.net/projects/ffmpeg/)"
    exit
  end
else
  print "If you want to download movies, you must install wget (http://www.gnu.org/software/wget/)\n"
end

