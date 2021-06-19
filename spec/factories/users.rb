FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }

    trait :confirmed do
      confirmed_at { DateTime.now }
    end

    trait :ac_created do
      contact_id { "1" }
    end

    trait :ac_tag_created do
      contact_tag_id { "2" }
    end
  end
end
