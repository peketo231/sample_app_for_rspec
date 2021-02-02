FactoryBot.define do
  factory :task do
    title { "title01" }
    status { 0 }
    association :user
  end
end
