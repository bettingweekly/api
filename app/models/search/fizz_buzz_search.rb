module Search
  class FizzBuzzSearch < BaseSearch # :nodoc:
    def paginate
      return ErrorSerializer.serialize(paginator.errors) unless paginator.valid?
      items = []

      paginator.start_point.upto(paginator.end_point) do |number|
        record = marked_favourites.select { |obj| obj.number == number }
        items << if record.empty?
                   FizzBuzz.new(number: number)
                 else
                   FizzBuzz.new(record.first.attributes)
                 end
      end

      items
    end
  end
end
