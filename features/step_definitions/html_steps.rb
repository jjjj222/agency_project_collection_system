#encoding: utf-8
Given /^(?:|I )am on(?: the)? (.+)$/ do |page_name|
  visit path_to(page_name)
end

# TODO: move towards this
When /^I fill in ([^"]*) with "([^"]*)"/i do |field_name, data|
  fill_in(field_name, with: data)
end

When /^I fill in the "([^"]*)" field with "([^"]*)"/i do |field_name, data|
  fill_in(field_name, with: data)
end

When /^I select "([^"]*)" for (.*)/i do |data, field_name|
  select data, from: (underscore_words field_name)
end

When /^I press "([^"]+)"$/i do |item_name|
  click_button(item_name)
end

#Then /^the (\w+) field should equal "([^"]*)"$/i do |item_name, data|
#  expect(find_field(item_name).value).to eq data
#end
Then /^the (.*) should be "([^"]*)"$/i do |item_name, data|
  find_by_id(underscore_words item_name).assert_text(:visible, Regexp.new(Regexp.escape(data), "i"))
end

Then /^I should see a notice about invalid (\w+)$/ do |field|
  @notice = find_by_id('notice')
  @notice.assert_text(:visible, Regexp.new(Regexp.escape(field), "i"))
end

Then /^I should see a notice telling me it was succ?essful$/ do
  @notice = find_by_id('notice')
  @notice.assert_text(:visible, /[sS]uccessfully/)
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  expect(page).to have_content(text)
end

Then /^(?:|I )should see something with "([^"]*)"$/ do |text|
  expect(page).to have_selector("*[value='#{text}']")
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  expect(page).to have_no_content(text)
end

Then /^(?:|I )should not see anything with "([^"]*)"$/ do |text|
  expect(page).not_to have_selector("*[value='#{text}']")
end


#When(/^I click "([^"]*)"$/) do |link|
#  click_link(link)
#end

Then (/^there should be a button "([^"]*)"$/) do |button|
  #page.should have_selector(:link_or_button, button)
  expect(page).to have_selector(:link_or_button, button)
end

#When /^(?:|I )click(?: the)? "([^"]*)" icon$/ do |icon|
#  #byebug
#  #save_and_open_page
#  puts page.body
#  object_id = "##{id_of(icon)}"
#  img = find(object_id)
#  img.click
#  #byebug
#  #visit path_to(iron)
#  #click_link(link)
#end
