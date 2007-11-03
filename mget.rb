#!/usr/bin/ruby -w
# v1.18
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

require 'Qt'

$LOAD_PATH.push(File.dirname(__FILE__))
$LOAD_PATH.push(File.dirname(__FILE__) + '/lib')

require 'mget/config'
require 'mget/mget'
require 'mget/mget_gui'
require 'mget/mget_output'
require 'mget/account_info'


class AccountInfoImpl < AccountInfoForm
  include Config
  def initialize(parent = nil, name = nil, modal = false, fl = 0)
    super
    @loaded = false
    unless username? and password?   # no previous downloads with passwords
      @loaded = true if loadConfig() # mark that the config was already loaded
    end
  end
  def loaded?
    @loaded
  end
  def slotSaveInfo(*k)
    unless @usernameEdit.text.empty? && @passwordEdit.text.empty?
      setUsername(@usernameEdit.text)
      setPassword(@passwordEdit.text)
      saveConfig() if @rememberPassword.checked? # save configuration to file
      self.accept()
    end
  end
end



## Adjustments needed for the GUI version
class Mget
  public :getMovie, :stats
end
## End of adjustments

class MgetGuiImpl < MovieGetGui
  VERSION = '1.18'
  def initialize(parent = nil, name = nil, modal = false, fl = 0)
    super
    @mget = Mget.new()
    @targets = Array.new
  end

  def slotPopulateTargets(*k)
    unless @targetEdit.text.empty?
      if File.exist?(@targetEdit.text)
        open(@targetEdit.text) do |f|
          f.each_line do |line|
            next if line.empty? || line =~ /^#/
            if line !~ /^http:\/\//
              setWarning("Invalid url: #{ line }")
              next
            end
            Qt::ListViewItem.new(@targetList,nil).setText(0, trUtf8(line) )
            @targets << line
          end
        end
      else
        Qt::ListViewItem.new(@targetList,nil).setText(0, trUtf8(@targetEdit.text) )
      end
      @targetEdit.text = ''
    end
  end

  def slotGetTargets(*k)
    w = MgetOutput.new
    w.show
    # pretend that we run as --input
    @mget.fromFile = true
    @mget.show     = false
    @mget.download = false
    if @radioShow.isChecked()
      @mget.show     = true
      @mget.download = false
    elsif @radioDownload.isChecked()
      @mget.download = true
      @mget.convert  = false
      @mget.remove   = false
    elsif @radioDownloadConvert.isChecked()
      @mget.convert  = true
      @mget.remove   = false
    else
      @mget.remove   = true
    end

    @targets.each do |target|
      @mget.target = target
      target = @mget.getMovie()
      next if target.class == Fixnum # the user probably skipped entering the password, so we couldn't get the url
      w.outputEdit.append("<a href=\"#{ target }\">#{ target }</a>")
    end
    str = @mget.stats()
    str.each do |line|
      w.outputEdit.append(line.to_s)
    end
  end

  def slotOpenTarget(*k)
    @targetEdit.text = Qt::FileDialog.getOpenFileName()
  end
  def slotCleanup(*k)
    @targets = Array.new
  end
end

if $0 == __FILE__
  a = Qt::Application.new(ARGV)
  w = MgetGuiImpl.new
  a.mainWidget = w
  w.show
  a.exec
end
