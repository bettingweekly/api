module Pagination
  class BasePagination
    include ActiveModel::Validations

    validates_numericality_of :page, greater_than: 0
    validates_numericality_of :per_page, greater_than: 0, less_than_or_equal_to: 1000, even: true
    validate :page_and_per_page_must_not_breach_limit

    attr_accessor :page,
                  :per_page

    attr_reader :limit

    def initialize(options = {})
      @page = options.fetch(:page, default_page).to_i
      @per_page = options.fetch(:per_page, default_per_page).to_i
      @limit = 100_000_000_000
    end

    def page_and_per_page_must_not_breach_limit
      if page * per_page > limit
        errors.add(:limit_breached, "response items must be less than or equal to #{limit}")
      end
    end

    def end_point
      page * per_page
    end

    def start_point
      (end_point - per_page) + 1
    end

    def first_page
      default_page
    end

    def last_page
      limit / per_page
    end

    def next_page
      page * per_page >= limit ? nil : page + 1
    end

    def prev_page
      page == 1 ? nil : page - 1
    end

    private

    def default_page
      1
    end

    def default_per_page
      100
    end
  end
end
