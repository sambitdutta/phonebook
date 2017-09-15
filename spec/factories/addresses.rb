FactoryGirl.define do
  factory :address do
    address_1 { Faker::Address.secondary_address }
    address_2 { Faker::Address.street_address }
    city { Faker::Address.city }
    pin_code { Faker::Address.zip_code }
    state { Faker::Address.state }
    association :contact
    country { Country.first }
    address_type { AddressType.first }
    
    
    trait :without_address_1 do
      address_1 ""
    end
    
    trait :without_city do
      city ""
    end
    
    trait :without_country do
      country nil
    end
    
  end
end
