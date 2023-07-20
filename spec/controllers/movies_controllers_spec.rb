require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  describe 'GET #index' do
    let!(:movies) do
      movies_array = []
      5.times do
        movie = FactoryBot.create(:movie, available_copies: 5)
        movies_array.push(movie)
      end
      movies_array
    end

    it 'renders all movies' do
      get :index
      parsed_response = JSON.parse(response.body)
      expect(parsed_response.size).to eq(movies.size)
      expect(response).to have_http_status(:success)

      movies.each_with_index do |movie, index|
        expect(parsed_response[index]['id']).to eq(movie.id)
        expect(parsed_response[index]['title']).to eq(movie.title)
        expect(parsed_response[index]['genre']).to eq(movie.genre)
        expect(parsed_response[index]['rating']).to eq(movie.rating.to_s)
        expect(parsed_response[index]['available_copies']).to eq(movie.available_copies)
      end
    end
  end
end
