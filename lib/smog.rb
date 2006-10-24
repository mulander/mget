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

require 'movie_site'

class Smog < MovieSite
  def get() # FIXME - doesn't work if url contains PL chars
    open(@url) do |f|
      f.each_line do |line|
        if line =~ /src="http:\/\/www\.wrzuta\.pl\/wrzuta_embed\.js\?wrzuta_key=.+?&wrzuta_flv=(http:\/\/www\.wrzuta\.pl\/vid\/file\/.+?\/.+?)&/
          return $1
        end
      end
    end
  end
end
