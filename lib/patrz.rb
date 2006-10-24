require 'movie_site'

class Patrz < MovieSite
  def get()
    open(@url) do |f|
      f.each_line do |line|
        if line =~ /src="http:\/\/www(\d)\.patrz\.pl\/player\/patrzplayer\.swf\?file=(\d{5})&amp;typ=(\d)&amp;server=(\d)/
          return 'http://www' + $4 + '.patrz.pl/uplx/5flv/' + $2 + '.flv'
        end
      end
    end
  end
end
