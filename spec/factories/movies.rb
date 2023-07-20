FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    genre { Faker::Book.genre }
    rating { 0 }
    available_copies { rand(1..10) }
  end
end
