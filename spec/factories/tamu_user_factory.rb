FactoryGirl.define do
  
  factory :tamu_user do
    trait(:default) { name "John Smith"; role "student"; email "test@tamu.edu"; netid "testnetid"; admin true; blocked false}
    trait(:name) { name "John Smith" }
    trait(:student) {role "student"}
    trait(:professor) {role  "professor"}
    trait(:unapproved_professor) {role  "unapproved_professor"}
    trait(:email) {email "test@tamu.edu"}
    trait(:admin) {admin true}
    trait(:not_admin) {admin false}
    trait(:blocked) {blocked true}
    trait(:not_blocked) {blocked false}
    trait (:updated) { 
      name "Updated Smith"
      role "professor"
      email "new_prof@tamu.edu"
      netid "othernetid"
    }
    trait (:invalid) {
      email "not_an_email"
    }
    trait(:master_admin) { master_admin true; admin true }

    factory :tamu_users do
      sequence(:name) { |n| "John Smith the #{n.ordinalize}" }
      sequence(:netid) { |n| "john#{n}" }
      sequence(:email) { |n| "john#{n}@tamu.edu" }
      sequence(:role) { |n| TamuUser.all_roles[n % TamuUser.all_roles.length] }
    end
  end

end
