FactoryGirl.define do
  factory :agency do
    
    trait(:default){
      name "Test Agency"
      email "agency@nonprofit.org"
      phone_number "800-700-6000"
    }
    trait(:name) { name "Test Agency" }
    trait(:email) { email "agency@nonprofit.org" }
    trait(:phone_number) { "800-700-6000" }
  end
end
