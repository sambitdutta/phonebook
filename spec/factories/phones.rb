FactoryGirl.define do
  factory :phone do
    number '+91-8826784855'
    association :contact
    phone_type_id { PhoneType.first.id}
    
    trait :invalid_phone do
      number 'Testing 123'
    end
    
    trait :without_phone_type do
      phone_type nil
    end
  end
end
