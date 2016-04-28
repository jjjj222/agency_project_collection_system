FactoryGirl.define do
    
  factory :project do
    
    trait(:default) {
        name  "Test Project";
        description  "This is the test project description";
        status "open";
        tags [""];
        created_at Time.now
        approved false;
    }
    
    trait(:test) {
        name  "Test Project";
        description  "This is the test project description";
        status "open";
        tags [""];
        created_at Time.now
        approved false;
    }
    
    trait(:invalid) {
        description  "This is the test project description";
        status "invlaid";
        created_at Time.now
        tags [""];
    }
    
    trait(:updated) {
        name  "Test Project updated";
        description  "This is the test project description updated";
        status "completed";
        created_at Time.now
        tags "updated";
    }
        
    trait(:name) { name "Test Project" }
    trait(:description) {description "This is the test project description"}
    trait(:status) {status  "open"}
    trait(:tags) {tags [""]}
    trait(:date) {created_at Time.now}
    trait(:old) { created_at 2.days.ago }
    trait(:approved) {approved true}
    trait(:unapproved) {approved false}  
    trait(:nil_approved) {approved nil}
  end
  
end
