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
require 'open-uri'
require 'net/http'
require 'uri'

class MovieSite
  include ErrorHandling
  include Config
  attr_reader :suffix
  def initialize(url)
    @log = Logger.new(logDir() + self.class.to_s + '.log')
    @error    = nil
    @url      = url
    @cookie   = ''
    @loggedIn = false
    @suffix   = '.flv'
    @mms      = false
    @skip     = false # skip this url?
    @useragent= 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.1) Gecko/20060111'
    @username = getUsername()
    @password = getPassword()
  end

  def mms?
    @mms
  end

  def skipped?
    @skip
  end

  private
  def passwordSet?
    return (@password.nil? || @password.empty?) ? false : true
  end
  def usernameSet?
    return (@username.nil? || @username.empty?) ? false : true
  end

  def loggedIn?
    return @loggedIn
  end

  def askAccountInfo
    w = AccountInfoImpl.new
    ret = 1
    unless w.loaded? # don't show the dialog if config loaded from file
      w.show
      ret = w.exec
    end
    @skip = true if ret.zero? # skip this file if the user clicked 'Abort'
    @username = getUsername()
    @password = getPassword()
  end

end
