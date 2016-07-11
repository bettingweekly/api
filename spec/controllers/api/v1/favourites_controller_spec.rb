require 'rails_helper'

RSpec.describe Api::V1::FavouritesController, type: :controller do
  describe 'FavouritesController#index' do
    it 'should respond with header content_type application/json' do
      get :index
      expect(response.status).to eq 200
      expect(response.content_type).to eq 'application/json'
    end

    context '#index' do
      it 'should return a list of marked favourites' do
        Favourite.create(number: 1, marked: true)
        Favourite.create(number: 3, marked: true)
        Favourite.create(number: 5, marked: true)
        Favourite.create(number: 15, marked: true)

        get :index
        expect(response_body['data'].count).to eq 4
        expect(response).to match_response_schema('favourite')
      end
    end

    context '#create' do
      it 'should create a new Fizz Buzz Favourite in the database' do
        post :create, number: 1
        expect(response).to match_response_schema('create_favourite')
      end

      context 'Error responses' do
        it 'should return an error response if the favourite number already exists' do
          Favourite.create(number: 1, marked: true)
          post :create, number: 1
          expect(response).to match_response_schema('errors/common')
        end

        it 'should return an error response when number param is missing' do
          post :create, id: 1
          expect(response).to match_response_schema('errors/common')
        end

        it 'should return an error response when the number param is greater than the limit' do
          post :create, number: 200_000_000_000
          expect(response).to match_response_schema('errors/common')
        end

        it 'should return an error response when the number param is less than 1' do
          post :create, number: 0
          expect(response).to match_response_schema('errors/common')
        end
      end
    end
  end
end
