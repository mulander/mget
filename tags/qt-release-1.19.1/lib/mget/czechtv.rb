# This file is part of the 'Movie Get' project.
#
# Copyright (C) 2006 Adam Wolk "mulander" <netprobe@gmail.com>
#                                "defc0n" <defc0n@da-mail.net>
#
# This file was initialy contributed by Marcin Babnis
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

require 'mget/movie_site'

class CzechTV < MovieSite

  def initialize(url)
    super(url)
    @mms         = true
    @convertable = false
  end

  def get()
    @out = ''
    @url1 = ''
    open(@url,{'User-Agent' => @useragent}) do |f|
      f.each_line do |line|
        if line =~ /<param name="(?:url|src)" value=".*?(http.*?)%22.*" \/>/
          @url1 = $1
          @url1.gsub!('%2F', '/')
          @url1.gsub!('%3A', ':')
        end
      end
    end

    if @url1 =~ /asx$/
      @suffix = '.wmv'
      open(@url1,{'User-Agent' => @useragent}) do |f|
        f.each_line do |line|
          if line =~ /<REF HREF="(.*)"\/>/
  	    @out = $1
	  end
	end
      end

    elsif @url1 =~ /ram$/
      @suffix = '.ra'
      open(@url1,{'User-Agent' => @useragent}) do |f|
        f.each_line do |line|
	  @out = line
	end
      end
    end

    if @out.empty?
      get()
    else
      return @out
    end
  end
end
