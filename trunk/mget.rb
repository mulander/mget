#!/usr/bin/ruby -w
# v0.08
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

require 'open-uri'

def youtube_get(url)
  id = ''
  open(url) do |f|
    f.each_line do |line|
        if line =~ /embed src="(http:\/\/.+?)"/
	  open($1) { |d| id = d.base_uri.to_s.scan(/.+video_id=(.+)/) }
  	  return "http://youtube.com/get_video.php?video_id=#{id}"
        end
      end
    end
end

def meta_get(url)
  if url =~ /\/watch\/(.*)\//
    id = $1
  end

  open("http://www.metacafe.com/fplayer.php?playerType=Portal&flashVideoPlayerVersion=3.0&itemID=" + id) do |f|
    f.each_line do |line|
      if line =~ /mediaURL=\"(http:\/\/.+?\.flv)\"/
        out = $1
        out.gsub!(/\%5B/, "[")
        out.gsub!(/\%20/, " ")
        out.gsub!(/\%5D/, "]")
        return out
      end
    end
  end
end

def google_get(url)
  open(url) do |f|
    f.each_line do |line|
      if line =~ /(http%3A%2F%2Fvp.video.google.com%2Fvideodownload%3Fversion.*)&messagesUrl/
        out = $1
        out.gsub!(/\%3A/, ":")
        out.gsub!(/\%2F/, "/")
        out.gsub!(/\%3F/, "?")
        out.gsub!(/\%3D/, "=")
        out.gsub!(/\%26/, "&")
        return out
      end
    end
  end
end

def myspace_get(url)
  id = 0
  if url =~ /videoID=(\d{10})/
    id = $1.to_s
  else
    print "Invalid myspace link, are you sure you copied it correctly?\n"
    exit
  end
  return 'http://content.movies.myspace.com/00' + id[0..4] \
  						+ '/' + id[-2..-1].reverse \
						+ '/' + id[-4 .. -3].reverse \
						+ '/' + id + '.flv'
end

def patrz_get(url)
  open(url) do |f|
    f.each_line do |line|
      if line =~ /src="http:\/\/www(\d)\.patrz\.pl\/player\/patrzplayer\.swf\?file=(\d{5})&amp;typ=(\d)&amp;server=(\d)/
        return 'http://www' + $4 + '.patrz.pl/uplx/5flv/' + $2 + '.flv'
      end
    end
  end
end

def smog_get(url)
  open(url) do |f|
    f.each_line do |line|
      if line =~ /src="http:\/\/www\.wrzuta\.pl\/wrzuta_embed\.js\?wrzuta_key=.+?&wrzuta_flv=(http:\/\/www\.wrzuta\.pl\/vid\/file\/.+?\/.+?)&/
        return $1
      end
    end
  end
end

url    = ARGV[0]
name   = ARGV[1]
suffix = '.'
target = ''

if url.nil? || url !~ /^http:\/\// || name.nil?
 puts "Usage:   mget url name"
 puts "url      - a valid google video, youtube, vids.myspace, smog.pl, patrz.pl or metacafe movie link"
 puts "filename - name used to save the file, without the extension"
 exit
end

convert = false

case url
  when /youtube/
    target = youtube_get(url)
    suffix += 'flv'
    convert = true
  when /metacafe/
    target = meta_get(url)
    suffix += 'flv'
    convert = true
  when /google/
    target = google_get(url)
    suffix += 'flv'
    convert = true
  when /vids\.myspace/
    target = myspace_get(url)
    suffix += 'flv'
    convert = true
  when /patrz/
    target = patrz_get(url)
    suffix += 'flv'
    convert = true
  when /smog/
    target = smog_get(url)
    suffix += 'flv'
    convert = true
  else
    print "Unsupported site: #{url}"
    exit
end

puts  target
if (ENV.has_key?('OS') && File.exists?(ENV['SystemRoot'] + '\wget.exe')) || system('which wget')
  print "Download the movie (using wget) now? [Y/n] "
  exit unless $stdin.gets.chomp =~ /^Y/i
    system("wget \"#{target}\" -O \"#{name + suffix}\"")

  if convert && ( (ENV.has_key?('OS') && File.exists?(ENV['SystemRoot'] + '\ffmpeg.exe')) || system('which ffmpeg') )
    print "Convert the flv movie to avi (using ffmpeg) now? [Y/n] "
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

