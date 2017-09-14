FactoryGirl.define do
  factory :contact do
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    
    association :user
    
    trait :without_first_name do
      first_name ""
    end
    
    trait :without_last_name do
      last_name ""
    end
  end
end
  
  
  
  
