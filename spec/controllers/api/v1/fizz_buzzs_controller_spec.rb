require 'rails_helper'

RSpec.describe Api::V1::FizzBuzzsController, type: :controller do
  describe 'FizzBuzzsController#index' do
    it 'should respond with header content_type application/json' do
      get :index
      expect(response.status).to eq 200
      expect(response.content_type).to eq('application/json')
    end
  end
end
