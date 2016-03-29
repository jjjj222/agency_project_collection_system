FactoryGirl.define do
    
  factory :project do
    
    trait(:default) {
        name  "Test Project";
        description  "This is the test project description";
        status "open";
        tags [""];
    }
    
    trait(:invalid) {
        description  "This is the test project description";
        status "invlaid";
        tags [""];
    }
    
    trait(:updated) {
        name  "Test Project updated";
        description  "This is the test project description updated";
        status "completed";
        tags "updated";
    }
        
    trait(:name) { name "Test Project" }
    trait(:description) {description "This is the test project description"}
    trait(:status) {status  "open"}
    trait(:tags) {tags [""]}
  end
  
end
