FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    genre { Faker::Book.genre }
    rating { rand(1.0..5.0).round(2) }
    available_copies { rand(1..10) }
  end
end
