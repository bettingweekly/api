module Pagination
  class FizzBuzzPagination < BasePagination # :nodoc:
    def url
      Rails.application.routes.url_helpers.api_v1_fizz_buzzs_url
    end
  end
end
