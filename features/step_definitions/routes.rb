# When /^I go to the (\w+) (.+) page for (?:the) (.*)$/i do |action, controller, param|
#   visit (controller_action_path action: action, controller: controller, param: param)
# end

When /I go to the (.*)$/i do |page_name|
  visit (path_to page_name)
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
    click_link(link)
end

When /^(?:|I )click(?: on)?(?: the)? "([^"]*)"$/ do |link|
    click_link(link)
end
