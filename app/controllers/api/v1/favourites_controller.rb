module Api
  module V1
    class FavouritesController < ApplicationController # :nodoc:
      def index
        render json: FizzBuzz.all
      end
    end
  end
end
