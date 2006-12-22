require 'logger'

module ErrorHandling

  def error?
    return !@error.nil?
  end
  
private
  def setError(string)
    @error = "[!] " + string
    puts @error
    @log.error(string)
  end
  
  def setWarning(string)
    @warn = "[*] " + string
    puts @warn
    @log.warn(string)
  end
  
  def setInfo(string)
    @info = "[?] " + string
    puts @info
    @log.info(string)
  end
  
  def logDir()
    path = './'
    if ENV.has_key?('APPDATA')
      path = ENV['APPDATA'] + '\\mget\\'
    else
      path = ENV['HOME'] + '/.mget/'
    end
    Dir.mkdir(path) unless File.exists?(path) && File.directory?(path)
    return path
  end
end