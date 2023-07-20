class RentalsService
  def create_rental(user_id, movie_id)
    movie = Movie.find(movie_id)

    raise StandardError, 'Movie is not available for rental' unless movie.available_copies.positive?

    rental = Rental.new(user_id: user_id, movie_id: movie_id, active: true)
    rental.save!

    movie.available_copies -= 1
    movie.save!

    rental
  rescue ActiveRecord::RecordNotUnique
    raise StandardError, 'User has already rented this movie'
  end

  def finish_rental(id, user_rating)
    rental = Rental.find(id)

    raise StandardError, 'Rental not found' unless rental
    raise StandardError, 'Rental already finished' unless rental.active

    movie = Movie.find(rental.movie_id)
    
    rentals = Rental.all

    if user_rating
        movie.rating = movie.rating + user_rating * rentals.length / rentals.length
    end

    movie.available_copies += 1

    ActiveRecord::Base.transaction do
      rental.update!(active: false)
      movie.save!
    end

    rental
  end
end
