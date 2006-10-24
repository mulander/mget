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
