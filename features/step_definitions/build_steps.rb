Given /^there is (?:the|a|an|another) (.*)$/ do |resource|
  eval (underscore_words resource)
end
