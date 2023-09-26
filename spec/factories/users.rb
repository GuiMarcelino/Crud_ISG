FactoryBot.define do
  factory :user do

    name { FFaker::NameBR.name }
    email { FFaker::Internet.email }
    password_digest { "ISG0923!!!" }
  end
end
