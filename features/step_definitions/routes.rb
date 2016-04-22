When /^I go to the (\w+) (.+) page for (?:the) (.*)$/i do |action, controller, param|
  visit (controller_action_path action: action, controller: controller, param: param)
end

When /^I go to the (.*s)(?:\s+|)page/i do |page_name|
  visit (eval "#{page_name}_url")
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
    #byebug
    click_link(link)
end

When /^(?:|I )click(?: the)? "([^"]*)"$/ do |link|
    click_link(link)
end
