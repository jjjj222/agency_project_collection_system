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
    trait(:unapproved_completed) {status "unapproved_completed"}
    trait(:completed) {status "completed"}
    trait(:nil_approved) {approved nil}

    factory(:projects) do
      sequence(:name) { |n| "Project #{n}" }
      sequence(:description) { |n| "description #{n}" }
      sequence(:status) { |n| Project.all_statuses[n % Project.all_statuses.length] }
      sequence(:approved) { |n| n.even? }
      sequence(:created_at) { |n| n.even? ? n.days.ago : n.hours.ago }
      sequence(:tags) { |n| ["tag#{n%10}"] }
    end
  end
  
end
