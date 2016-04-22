FactoryGirl.define do
  
  factory :tamu_user do
    trait(:default) { name "John Smith"; role "student"; email "test@tamu.edu"; netid "testnetid"; admin true}
    trait(:name) { name "John Smith" }
    trait(:student) {role "student"}
    trait(:professor) {role  "professor"}
    trait(:unapproved_professor) {role  "unapproved_professor"}
    trait(:email) {email "test@tamu.edu"}
    trait(:admin) {admin true}
    trait(:not_admin) {admin false}
    trait (:updated) { 
      name "Updated Smith"
      role "professor"
      email "new_prof@tamu.edu"
      netid "othernetid"
    }
    trait (:invalid) {
      email "not_an_email"
    }
  end

end
