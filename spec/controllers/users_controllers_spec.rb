require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #recommendations' do
    let!(:user) { FactoryBot.create(:user) }

    context 'when the user exists' do
      let!(:favorite_movies) { FactoryBot.create_list(:movie, 10) }

      before do
        user.favorites << favorite_movies
      end

      it 'returns recommendations for the user' do
        get :recommendations, params: { id: user.id }
        parsed_response = JSON.parse(response.body)
        expect(response).to have_http_status(:success)
        expect(parsed_response).to be_an(Array)
      end
    end

    context 'when the user does not exist' do
      it 'returns status :not_found and an error message' do
        get :recommendations, params: { id: 9999 }
        parsed_response = JSON.parse(response.body)
        expect(response).to have_http_status(:not_found)
        expect(parsed_response['error']).to eq('User not found')
      end
    end
  end

  describe 'GET #rented_movies' do
    let!(:user) { FactoryBot.create(:user) }

    context 'when the user exists and has rented movies' do
      let!(:rented_movies) { FactoryBot.create_list(:movie, 5) }

      before do
        user.rented << rented_movies
      end

      it 'returns the movies rented by the user' do
        get :rented_movies, params: { id: user.id }
        parsed_response = JSON.parse(response.body)
        expect(response).to have_http_status(:success)
        expect(parsed_response).to be_an(Array)
        expect(parsed_response.size).to eq(5)
      end
    end

    context 'when the user does not exist' do
      it 'returns status :not_found and an error message' do
        get :rented_movies, params: { id: 9999 }
        parsed_response = JSON.parse(response.body)
        expect(response).to have_http_status(:not_found)
        expect(parsed_response['error']).to eq('User not found')
      end
    end
  end
end
