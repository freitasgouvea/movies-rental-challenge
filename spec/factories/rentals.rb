FactoryBot.define do
  factory :rental do
    association :user
    association :movie
    active { true }
  end
end
