When /^I go to the (\w+) (.+) page for (?:the) (.*)$/i do |action, controller, param|
  controller_name = underscore_words controller
  param_name = underscore_words param

  # compute the url helper method name, e.g. edit_tamu_user
  path_name = 
    if not ["index","show"].include? action
      "#{action}_#{controller_name}".downcase
    else
      controller_name
    end

  code = "#{path_name}_url #{param_name}"
  visit (eval code)
end
When /^I go to the (.*s)(?:\s+|)page/i do |page_name|
  visit (eval "#{page_name}_url")
end
