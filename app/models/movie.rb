class Movie < ActiveRecord::Base
  has_many :ratings, dependent: :destroy
  
  def good
    ratings.good.count > 99 ? "99+" : ratings.good.count
  end
  
  def bad
    ratings.bad.count > 99 ? "99+" : ratings.bad.count
  end
  
  def self.without_user(user)
    if Rating.where("user_id = ?", user.id).count == 0
      self
    else
      where("id not in (?)", (Rating.where("user_id = ?", user.id).map(&:movie_id)))
    end
  end
  
  def self.scrape_imdb(imdb_id)
    return nil if find_by_imdb(imdb_id)
    
    require 'open-uri'
    new_movie = Movie.new(imdb: imdb_id)
    doc = Nokogiri::HTML(open("http://www.imdb.com/title/#{imdb_id}/"))
    title = /^(.+) \((\d{4})\)$/.match(doc.css("title").inner_text.gsub(/IMDb - /i, "").gsub(/ - imdb/i, "")) # gets title
    
    new_movie.title = title[1]
    new_movie.year = title[2].to_i
    new_movie.runtime = /(\d+) min.+$/.match(doc.css(".infobar").inner_text)[1].to_i
    new_movie.description = doc.css("p[itemprop=description]").inner_text.gsub("\n", " ")
    new_movie.imdb = imdb_id
    new_movie.youtube = get_youtube(new_movie.title)
    new_movie.save
    
  end
  
  def self.get_youtube(title)
    require 'open-uri'
    doc = Nokogiri::HTML(open("http://www.youtube.com/results?search_query=#{title.gsub(" ", "+")}+trailer&search_duration=short"))
    doc.css("#search-results h3 a").first['href'].gsub("/watch?v=", "")
  end
end
