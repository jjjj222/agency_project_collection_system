Given /^there is (?:the|a|an) (.*)$/ do |resource|
  eval (underscore_words resource)
end
