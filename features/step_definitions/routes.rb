When /^I go to the (\w+) (.+) page for (?:the) (.*)$/i do |action, controller, param|
  controller_name = controller.downcase.gsub /\s+/, '_'
  param_name = param.downcase.gsub /\s+/, '_'

  # compute the url helper method name, e.g. edit_tamu_user
  path_name = "#{action}_#{controller_name}".downcase

  code = "#{path_name}_url #{param_name}"
  visit (eval code)
end
