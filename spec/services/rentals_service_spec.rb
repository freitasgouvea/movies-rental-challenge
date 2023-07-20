require 'rails_helper'

RSpec.describe RentalsService do
  let(:service) { described_class.new }

  describe '#create_rental' do
    let(:user) { FactoryBot.create(:user) }
    let(:movie) { FactoryBot.create(:movie, available_copies: 2) }

    context 'when the rental is successful' do
      it 'creates a new rental' do
        expect do
          service.create_rental(user.id, movie.id)
        end.to change(Rental, :count).by(1)
      end

      it 'decreases available copies of the movie' do
        expect do
          service.create_rental(user.id, movie.id)
          movie.reload
        end.to change(movie, :available_copies).by(-1)
      end

      it 'returns the created rental' do
        rental = service.create_rental(user.id, movie.id)
        expect(rental).to be_a(Rental)
        expect(rental.user_id).to eq(user.id)
        expect(rental.movie_id).to eq(movie.id)
      end
    end

    context 'when the movie is not available for rental' do
      before { movie.update(available_copies: 0) }

      it 'raises a StandardError' do
        expect do
          service.create_rental(user.id, movie.id)
        end.to raise_error(StandardError, 'Movie is not available for rental')
      end
    end

  end
end
