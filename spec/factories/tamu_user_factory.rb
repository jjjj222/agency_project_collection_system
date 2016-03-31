FactoryGirl.define do
  
  factory :tamu_user do
    trait(:default) { name  "John Smith"; role  "student"; email "test@tamu.edu"}
    trait(:name) { name "John Smith" }
    trait(:student) {role "student"}
    trait(:professor) {role  "professor"}
    trait(:email) {email "test@tamu.edu"}
    trait (:updated) { 
      name "Updated Smith"
      role "professor"
      email "new_prof@tamu.edu"
    }
    trait (:invalid) {
      role "not a role"
    }
  end

end
