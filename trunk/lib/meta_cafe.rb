require 'movie_site'

class MetaCafe < MovieSite
  def get()
    if @url =~ /\/watch\/(.*)\//
      id = $1
    end

    open("http://www.metacafe.com/fplayer.php?playerType=Portal&flashVideoPlayerVersion=3.0&itemID=" + id) do |f|
      f.each_line do |line|
        if line =~ /mediaURL=\"(http:\/\/.+?\.flv)\"/
          out = $1
          out.gsub!(/\%5B/, "[")
          out.gsub!(/\%20/, " ")
          out.gsub!(/\%5D/, "]")
          return out
        end
      end
    end
  end
end
