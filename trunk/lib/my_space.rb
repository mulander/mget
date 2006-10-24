require 'movie_site'

class MySpace < MovieSite
  def get()
    id = 0
    if @url =~ /videoID=(\d{10})/i
      id = $1.to_s
    else
      print "Invalid myspace link, are you sure you copied it correctly?\n"
      exit
    end
    return 'http://content.movies.myspace.com/00' + id[0..4] \
    						+ '/' + id[-2..-1].reverse \
  	     					+ '/' + id[-4 .. -3].reverse \
		    				+ '/' + id + '.flv'
  end
end
