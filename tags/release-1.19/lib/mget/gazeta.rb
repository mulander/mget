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

class Gazeta < MovieSite
  def get()
    id = @url.scan(/http:\/\/wideo\.gazeta\.pl\/wideo\/.+?,.+?,(.+?)\.html$/).flatten
    open("http://wideo.gazeta.pl/w?xx=#{ id }&v=2") do |f|
      f.each_line do |line|
        if line =~ /movieSRC=\'http:\/\/wideo\.gazeta\.pl\/control2\.swf\?plik=(http:\/\/video\.gazeta\.pl\/.+?\/.+?\/.+?)\&title=/
          return $1
        end
      end
    end
  end
end