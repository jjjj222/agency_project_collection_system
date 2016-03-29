FactoryGirl.define do
    
  factory :project do
    
    trait(:default) {
        name  "Test Project";
        description  "This is the test project description";
        status "open";
        tags [""];
    }
        
    trait(:name) { name "John Smith" }
    trait(:description) {description "This is the test project description"}
    trait(:status) {status  "open"}
    trait(:tags) {tags [""]}
  end
  
end
