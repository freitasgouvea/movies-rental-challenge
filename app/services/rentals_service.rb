class RentalsService
  def create_rental(user_id, movie_id)
    movie = Movie.find(movie_id)

    raise StandardError, 'Movie is not available for rental' unless movie.available_copies.positive?

    rental = Rental.new(user_id: user_id, movie_id: movie_id)
    rental.save!

    movie.available_copies -= 1
    movie.save!

    rental
  rescue ActiveRecord::RecordNotUnique
    raise StandardError, 'User has already rented this movie'
  end
end
