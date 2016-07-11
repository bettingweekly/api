module Api
  module V1
    class FavouritesController < ApplicationController # :nodoc:
      def index
        render json: Search::FavouritesSearch.new(params).all
      end

      def create
        params.merge!(marked: true)
        record = Favourite.create(params.permit(:number, :marked))
        if record.valid?
          render json: FizzBuzz.new(record.attributes)
        else
          render json: ErrorSerializer.serialize(record.errors)
        end
      end
    end
  end
end
