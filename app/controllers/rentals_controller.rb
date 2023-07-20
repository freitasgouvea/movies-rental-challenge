class RentalsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    movie = Movie.find(params[:movie_id])

    rental_service = RentalsService.new
    rental = rental_service.create_rental(user.id, movie.id)

    render json: rental, status: :created
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User or movie not found' }, status: :not_found
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
