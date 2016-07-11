module Search
  class BaseSearch # :nodoc:
    attr_reader :paginator

    def initialize(params)
      @paginator = Pagination::BasePagination.new(params)
    end

    private

    def marked_favourites
      @relation ||= Favourite.in_range_and_marked(paginator.start_point,
                                                  paginator.end_point)
    end
  end
end
