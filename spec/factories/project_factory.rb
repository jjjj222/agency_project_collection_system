FactoryGirl.define do
    
  factory :project do
    
    trait(:default) {
        name  "Test Project";
        description  "This is the test project description";
        status "open";
        tags [""];
        created_at "2016-04-26 06:19:16"
        approved false;
    }
    
    trait(:test) {
        name  "Test Project";
        description  "This is the test project description";
        status "open";
        tags [""];
        created_at "2016-04-26 06:19:16"
        approved false;
    }
    
    trait(:invalid) {
        description  "This is the test project description";
        status "invlaid";
        created_at "2016-04-26 06:19:16"
        tags [""];
    }
    
    trait(:updated) {
        name  "Test Project updated";
        description  "This is the test project description updated";
        status "completed";
        created_at "2016-04-26 06:19:16"
        tags "updated";
    }
        
    trait(:name) { name "Test Project" }
    trait(:description) {description "This is the test project description"}
    trait(:status) {status  "open"}
    trait(:tags) {tags [""]}
    trait(:date) {created_at "2016-04-26 06:19:16"}
    trait(:approved) {approved true}
    trait(:unapproved) {approved false}  
    trait(:nil_approved) {approved nil}
  end
  
end
