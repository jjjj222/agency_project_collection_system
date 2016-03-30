When /^I go to the agency page for the current agency$/i do
  visit (agencies_path)
end


Given(/^I am on agencies page$/) do
    visit (agencies_path)
    save_page
end

When(/^I click "([^"]*)"$/) do |link|
  click_link(link)
end

Then(/^I should see "([^"]*)" page$/) do |arg1|
 expect(visit(agencies_path 1))
end



# When /^I go to the (.+) page for (?:the) (.*)$/i do |controller, param|
#   controller_name = controller.downcase.gsub /\s+/, '_'
#   param_name = param.downcase.gsub /\s+/, '_'

#   # compute the url helper method name, e.g. edit_tamu_user
#   path_name = "#{controller_name}".downcase

#   code = "#{path_name}_url #{param_name}"
#   visit (eval code)
# end
