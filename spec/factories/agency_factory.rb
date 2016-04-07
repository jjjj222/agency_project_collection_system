FactoryGirl.define do
  factory :agency do
    
    trait(:default){
      name "Test Agency"
      email "agency@nonprofit.org"
      phone_number "800-700-6000"
      approved true
    }
    trait(:name) { name "Test Agency" }
    trait(:email) { email "agency@nonprofit.org" }
    trait(:phone_number) { "800-700-6000" }
    trait(:approved) {approved true}
    trait(:unapproved) {approved false}
  end
end
