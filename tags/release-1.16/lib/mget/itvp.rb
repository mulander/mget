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

class ITVP < MovieSite

  def initialize(url,config)
    super(url,config)
    @mms         = true
    @convertable = false
  end
  
  def get()
    @suffix = '.wmv'
    id = @url.scan(/http:\/\/www\.itvp\.pl\/sys\/media\/i\.tvp\/idm\/(.+?)\/rodzaj\/.+?\/width\/.+?\/height\/.+?/).flatten
    @url = "http://mediagen.itvp.pl/media/dispatch.php?idm=#{ id }&rodzaj=1"
    open(@url) do |f|
      f.each_line do |line|
        if line =~ /URL=(http:\/\/mediagen\.itvp\.pl\/media\/dispatch\.php\?type=.+?&spl=0)"\>/
          open($1) do |f_1|
            f_1.each_line do |line_1|
              if line_1 =~ /\<PARAM NAME="URL" VALUE="(.+?)"\>/
                open($1) do |f_2|
                  f_2.each_line do |line_2|
                    if line_2 =~ /target="\_blank"\/\>\<ref href="(.+?)" \/>/
                      out = $1
                      out.gsub!(/\%2f/, "/")
                      out.gsub!(/\%2b/, "+")
                      out.gsub!(/\%3d/, "=")
                      return out
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
