class Movie < ActiveRecord::Base
  def self.get_ratings 
    #['G','PG','PG-13','R']
    Movie.select(:rating).distinct.inject([]) { |a, m| a.push m.rating}
  end
end
