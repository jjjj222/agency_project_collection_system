When /I go to the (.*)$/i do |page_name|
  visit (path_to page_name)
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
    click_link(link)
end

When /^(?:|I )click(?: on)?(?: the)? "([^"]*)"$/ do |link|
    click_link(link)
end
