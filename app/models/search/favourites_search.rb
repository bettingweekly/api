module Search
  class FavouritesSearch < BaseSearch # :nodoc:
    def all
      marked_favourites.map do |favourite|
        FizzBuzz.new(favourite.attributes)
      end
    end
  end
end
