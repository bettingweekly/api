require 'rails_helper'

RSpec.describe Api::V1::FizzBuzzsController, type: :controller do
  describe 'FizzBuzzsController#index' do
    it 'should respond with header content_type application/json' do
      get :index
      expect(response.status).to eq 200
      expect(response.content_type).to eq('application/json')
    end

    context 'No query params' do
      it 'should return a list of 100 FizzBuzz items and should pass schema validation' do
        get :index
        expect(response_body['data'].count).to eq 100
        expect(response).to match_response_schema('fizz_buzz')
      end
    end

    context 'With query params' do
      it 'should return the 2nd page of results' do
        get :index, page: 2
        expect(response_body['links']['next']).to eq api_v1_fizz_buzzs_url + '?page=3&per_page=100'
        expect(response).to match_response_schema('fizz_buzz')
      end

      it 'should return a list of 10 FizzBuzz items' do
        get :index, per_page: 10
        expect(response_body['data'].count).to eq 10
        expect(response).to match_response_schema('fizz_buzz')
      end
    end

    describe 'Error messages' do
      context 'Negative numbers' do
        it 'should return an Array of errors when page or per_page are negative' do
          get :index, page: -2, per_page: -10
          expect(response).to match_response_schema('errors/common')
        end
      end

      context 'Per page limit breached' do
        it 'should return error response when per_page is greater than 1000 limit' do
          get :index, per_page: 3000
          expect(response).to match_response_schema('errors/common')
        end
      end
    end
  end
end
