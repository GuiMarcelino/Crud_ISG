FactoryBot.define do
  factory :comment do
    association :post

    name { FFaker::NameBR.name }
    comment { FFaker::Lorem.word }
  end
end
