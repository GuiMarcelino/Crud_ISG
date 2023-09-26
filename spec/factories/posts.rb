FactoryBot.define do
  factory :post do
    association :user

    title { FFaker::NameBR.name }
    text { FFaker::Lorem.word }
  end
end
