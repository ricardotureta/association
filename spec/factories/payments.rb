FactoryBot.define do
  factory :payment do
    person 
    amount { 199 }
    paid_at { "2024-04-05" }
  end
end
