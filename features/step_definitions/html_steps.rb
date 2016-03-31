#encoding: utf-8
When /^I fill in the "(\w+)" field with "([^"]*)"/i do |field_name, data|
  fill_in(field_name, with: data)
end

When /^I press "([^"]+)"$/i do |item_name|
  click_button(item_name)
end

Then /^the (\w+) field should be "([^"]*)"$/i do |item_name, data|
  expect(find_field(item_name.capitalize).value).to eq data
end
Then /^the (\w+) should be "([^"]*)"$/i do |item_name, data|
  find_by_id(item_name).assert_text(:visible, Regexp.new(Regexp.escape(data), "i"))
end

Then /^I should see a notice about invalid (\w+)$/ do |field|
  @notice = find_by_id('notice')
  @notice.assert_text(:visible, Regexp.new(Regexp.escape(field), "i"))
end

Then /^I should see a notice telling me it was sucessful$/ do
  @notice = find_by_id('notice')
  @notice.assert_text(:visible, "successfully")
end

When(/^I click "([^"]*)"$/) do |link|
  click_link(link)
end
