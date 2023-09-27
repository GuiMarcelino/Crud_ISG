FactoryBot.define do
  factory :comment do
    association :post

    name { FFaker::NameBR.name }
    description { FFaker::Lorem.word }
  end
end
