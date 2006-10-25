require 'logger'

module ErrorHandling

  def error?
    return !@error.nil?
  end
  
private
  def setError(string)
    @error = "[!]" + string + "\n"
    puts @error
    @log.error(string)
  end
  
  def setWarning(string)
    @warn = "[*]" + string + "\n"
    puts @warn
    @log.warn(string)
  end
  
  def setInfo(string)
    @info = "[?]" + string + "\n"
    puts @info
    @log.info(string)
  end
end