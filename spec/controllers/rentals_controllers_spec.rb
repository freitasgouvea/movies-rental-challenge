require 'rails_helper'

RSpec.describe RentalsController, type: :controller do
  describe 'POST #create' do
    let(:user) { FactoryBot.create(:user) }
    let(:movie) { FactoryBot.create(:movie, available_copies: 2) }

    context 'when the rental is successful' do
      it 'creates a new rental' do
        post :create, params: { user_id: user.id, movie_id: movie.id }

        expect(Rental.count).to eq(1)
      end

      it 'decreases available copies of the movie' do
        post :create, params: { user_id: user.id, movie_id: movie.id }

        movie.reload
        expect(movie.available_copies).to eq(1)
      end

      it 'returns status code 201 (created)' do
        post :create, params: { user_id: user.id, movie_id: movie.id }

        expect(response).to have_http_status(:created)
      end
    end

    context 'when the movie is not available for rental' do
      let(:movie) { FactoryBot.create(:movie, available_copies: 0) }

      it 'does not create a new rental' do
        post :create, params: { user_id: user.id, movie_id: movie.id }

        expect(Rental.count).to eq(0)
      end
    end

    context 'when the user has already rented this movie' do
      before do
        Rental.create(user: user, movie: movie, active: true)
      end

      it 'does not create a new rental' do
        post :create, params: { user_id: user.id, movie_id: movie.id }

        expect(Rental.count).to eq(1)
      end
    end

    context 'when the user or movie is not found' do
      it 'returns an error message' do
        post :create, params: { user_id: 9999, movie_id: movie.id }

        expect(Rental.count).to eq(0)
      end
    end
  end
end
