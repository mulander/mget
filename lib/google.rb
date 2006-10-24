require 'movie_site'

class Google < MovieSite
    def get()
      open(@url) do |f|
        f.each_line do |line|
          if line =~ /(http%3A%2F%2Fvp.video.google.com%2Fvideodownload%3Fversion.*)&messagesUrl/
            out = $1
            out.gsub!(/\%3A/, ":")
            out.gsub!(/\%2F/, "/")
            out.gsub!(/\%3F/, "?")
            out.gsub!(/\%3D/, "=")
            out.gsub!(/\%26/, "&")
            return out
          end
        end
      end
    end
end
