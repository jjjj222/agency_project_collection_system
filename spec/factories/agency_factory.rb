FactoryGirl.define do
  factory :agency do
    
    trait(:default){
      name "Test Agency"
      email "agency@nonprofit.org"
      phone_number "800-700-6000"
      approved true
      provider "google_oauth2"
    }
    trait(:name) { name "Test Agency" }
    trait(:email) { email "agency@nonprofit.org" }
    trait(:phone_number) { "800-700-6000" }
    trait(:approved) {approved true}
    trait(:unapproved) {approved false}
    trait(:nil_approved) {approved nil}
    trait(:invalid) { name "" }
    trait(:other) {
      name "Other Agency"
      email "other@nonprofit.org"
      phone_number "100-200-3000"
      approved true
    }
    trait (:updated) {
      name "New Agency"
    }
  end
end
