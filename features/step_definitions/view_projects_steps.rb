#encoding: utf-8
Given /^I am logged in as (?:a|an) (.+)$/i do |user_type|
    if user_type == "TAMU User"
        #visit login_path
        #@current_user ||= TamuUser.create! name: "Test Smith", email: "test@test.org", role: "student", admin: true
        #@current_user = current_user
        #byebug
    end
end

Then /^I should see a list of all (projects)$/ do |model|
    pending
end

When /^I select the (programming) tag$/ do |tag_name|
    pending
end

Then /^I should (?:see only|only see) (projects) with the (programming) tag/ do |model, tag|
    pending
end

