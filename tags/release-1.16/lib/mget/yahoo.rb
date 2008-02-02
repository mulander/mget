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

require 'mget/movie_site'

class Yahoo < MovieSite

  def initialize(url,config)
    super(url,config)
    @mms         = true
    @convertable = false
  end
  
  def get()
    @suffix = '.wmv'
    id = @url.scan(/http:\/\/movies\.yahoo\.com\/mv\/mf\/frame\?theme=minfo&lid=.+?\.(.+?)-.+?\,.+?&type=t/).flatten
    @url = "http://playlist.yahoo.com/makeplaylist.dll?id=#{ id }"
    open(@url) do |f|
      f.each_line do |line|
        if line =~ /\<Ref href = "(.+?)" \/\>/
          return $1
        end
      end
    end
  end
end