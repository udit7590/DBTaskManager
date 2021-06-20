FactoryBot.define do
  factory :user do
    email     { FFaker::Internet.email }
    password  { "password" }

    trait :confirmed do
      confirmed_at { DateTime.now }
    end

    trait :ac_created do
      active_campaign_contact_id { "1" }
    end

    trait :ac_tag_created do
      contact_tag_id { "2" }
    end
  end
end
