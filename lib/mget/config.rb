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
module Config
  @@youtube = { 'username' => '', 'password' => '' }
  @@type    = nil
  public
  def setUsername(username)
    @@youtube['username'] = username
  end
  def setPassword(password)
    @@youtube['password'] = password
  end
  def getUsername()
    @@youtube['username'].nil? ? nil : @@youtube['username']
  end
  def getPassword()
    @@youtube['password'].nil? ? nil : @@youtube['password']
  end
  def password?
    (@@youtube['password'].empty? or @@youtube['password'] == '') ? false : true
  end
  def username?
    (@@youtube['username'].empty? or @@youtube['username'] == '') ? false : true
  end
  # Load the current configuration from disk
  def loadConfig()
    target = getConfigPath() + @@type + 'mget.conf'
    if File.exists?(target)
      File.open(target) do |config|
       config.each do |line|
         @@youtube['username'],@@youtube['password'] = line.sub("\n",'').split(':')
       end
      end
    end
    return (password? and username?) # return true if username and password are set
  end
  # Save the current configuration to disk
  def saveConfig()
    path = getConfigPath()
    Dir.mkdir(path) unless File.exists?(path) && File.directory?(path)
    target =  path + @@type + 'mget.conf'
    f = File.new(target,"w")
    f << @@youtube['username'] + ':' + @@youtube['password'] + "\n" # save in username:passwd format
    f.close
  end
  # Return the path to the config file
  def getConfigPath()
    path = './'
    if ENV.has_key?('APPDATA')
      path = ENV['APPDATA'] + '\\mget\\'
      @@type = '\\'
    else
      path = ENV['HOME'] + '/.mget/'
      @@type = '/'
    end
    return path
  end
end