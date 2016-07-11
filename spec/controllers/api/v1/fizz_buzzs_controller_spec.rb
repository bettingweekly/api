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
  end
end
