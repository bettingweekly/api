module Api
  module V1
    class FizzBuzzsController < ApplicationController # :nodoc:
      def index
        render json: Search::FizzBuzzSearch.new(params).paginate
      end
    end
  end
end
